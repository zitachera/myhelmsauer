package handle

import (
	"context"
	"encoding/json"
	"fmt"
	"net/http"

	"github.com/go-chi/chi/v5"
)

// vielleicht völlig von chin trennen
// und nur auf http handler konzentrieren?
// villeicht macht sogar ein argument system sinn:
// handle.WithParameter(h, para)
// handle.WithTwoParameter(h, para, para2)
// das wird halt leider schnell unübersichtlich

type URLParameter string

func (p URLParameter) From(r *http.Request) string {
	return chi.URLParam(r, string(p))
}

func (p URLParameter) FromContext(ctx context.Context) string {
	return chi.URLParamFromCtx(ctx, string(p))
}

func (p URLParameter) Ref() string {
	return string("{" + p + "}")
}

func Post[In, Out any](router chi.Router, pattern string, h func(context.Context, In) (Out, error)) {
	router.Post(pattern, newHandlerWithInputBody(h))
}

func Get[Out any](router chi.Router, pattern string, h func(context.Context) (Out, error)) {
	router.Get(pattern, newHandler(h))
}

func Delete[Out any](router chi.Router, pattern string, h func(context.Context) (Out, error)) {
	router.Delete(pattern, newHandler(h))
}

func Put[In, Out any](router chi.Router, pattern string, h func(context.Context, In) (Out, error)) {
	router.Put(pattern, newHandlerWithInputBody(h))
}

func newHandler[Out any](h func(context.Context) (Out, error)) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		out, err := h(r.Context())

		if err != nil {
			handleError(w, err, http.StatusInternalServerError)
			return
		}
		if err := json.NewEncoder(w).Encode(out); err != nil {
			handleError(w, err, http.StatusInternalServerError)
			return
		}
	}
}

func newHandlerWithInputBody[In, Out any](h func(context.Context, In) (Out, error)) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var in In
		if err := json.NewDecoder(r.Body).Decode(&in); err != nil {
			handleError(w, err, http.StatusBadRequest)
			return
		}
		out, err := h(r.Context(), in)

		if err != nil {
			handleError(w, err, http.StatusInternalServerError)
			return
		}
		if err := json.NewEncoder(w).Encode(out); err != nil {
			handleError(w, err, http.StatusInternalServerError)
			return
		}
	}
}

func handleError(w http.ResponseWriter, err error, code int) {
	if statusErr, is := err.(Error); is {
		code = statusErr.HttpCode
	}
	msg := err.Error()
	fmt.Println(code, msg)
	http.Error(w, msg, code)
}

func Errorf(code int, format string, args ...any) error {
	return Error{
		Inner:    fmt.Errorf(format, args...),
		HttpCode: code,
	}
}

type Error struct {
	Inner    error
	HttpCode int
}

func (e Error) Unwrap() error {
	return e.Inner
}

func (e Error) Error() string {
	return e.Inner.Error()
}
