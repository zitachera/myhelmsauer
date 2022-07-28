package account

import (
	"context"
	"fmt"
	"net/http"

	"gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/api/auth"
	"gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/api/handle"
	"gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/data"
)

type info struct {
	Gruppe string `json:"gruppe"`
	Name   string `json:"name"`
}

func Info(ctx context.Context) (info, error) {
	c := auth.GetClient(ctx)

	// recheck login because procilent will not do this for us
	msg, ok, err := c.Login()
	if err != nil {
		return info{}, err
	}
	if !ok {
		return info{}, handle.Error{
			Inner:    fmt.Errorf(msg),
			HttpCode: http.StatusForbidden,
		}
	}

	if c.SubAccount != "" {
		return info{
			Gruppe: data.MyHelmsauerGroup,
			Name:   c.SubAccount,
		}, nil
	}

	return info{
		Gruppe: c.Gruppe,
		Name:   c.User,
	}, nil
}
