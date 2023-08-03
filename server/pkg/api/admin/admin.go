package admin

import (
	"context"
	"net/http"
	"regexp"

	"gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/api/auth"
	"gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/api/handle"
	"gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/data"
)

type getUserOutput struct {
	Name         string `json:"name"`
	Mainname     string `json:"mainname"`
	Gruppe       string `json:"gruppe"`
	Creationdate string `json:"creationdate"`
}

func GetUsers(ctx context.Context) ([]getUserOutput, error) {
	users, err := data.LoadUsers()
	if err != nil {
		return nil, err
	}
	out := make([]getUserOutput, len(users))
	for i, user := range users {
		out[i] = getUserOutput{
			Name:         user.Name,
			Mainname:     user.Mainname,
			Gruppe:       user.Gruppe,
			Creationdate: user.Creationdate,
		}
	}
	return out, nil
}

const (
	UserNameID handle.URLParameter = "userNameID"
)

func DeleteUser(ctx context.Context) (string, error) {
	name := UserNameID.FromContext(ctx)
	if err := data.RemoveUser(name); err != nil {
		return "", err
	}
	return name, nil
}

type postUserInput struct {
	Name         string `json:"name"`
	Password     string `json:"password"`
	Mainname     string `json:"mainname"`
	Gruppe       string `json:"gruppe"`
	MainPassword string `json:"mainPassword"`
}

var userNamePattern = regexp.MustCompile("^[a-zA-Z0-9]+$")

func PostUser(ctx context.Context, user postUserInput) (string, error) {

	if !userNamePattern.MatchString(user.Name) {
		return "", handle.Errorf(http.StatusBadRequest,
			"invalid user name %q", user.Name)
	}

	return user.Name, data.AddUser(
		user.Name,
		auth.PassHash(user.Password),
		user.Mainname,
		user.MainPassword,
		user.Gruppe,
	)
}

func PutUser(ctx context.Context, user postUserInput) (string, error) {
	current, err := data.LoadUser(user.Name)
	if err != nil {
		return "", err
	}

	if user.Mainname != "" {
		current.Mainname = user.Mainname
	}
	if user.Gruppe != "" {
		current.Gruppe = user.Gruppe
	}
	if user.MainPassword != "" {
		current.Password = user.MainPassword
	}
	if user.Password != "" {
		current.Passhash = auth.PassHash(user.Password)
	}

	return user.Name, data.UpdateUser(
		current.Name,
		current.Passhash,
		current.Mainname,
		current.Password,
		current.Gruppe,
	)
}

func GetVerträge(ctx context.Context) ([]string, error) {
	user := UserNameID.FromContext(ctx)
	vertragIDs, err := data.LoadVertragIds(user)
	if err != nil {
		return nil, err
	}
	return vertragIDs, nil
}

func PutVerträge(ctx context.Context, vertragIds []string) ([]string, error) {
	user := UserNameID.FromContext(ctx)
	if err := data.RemoveVerträgeFromUser(user); err != nil {
		return nil, err
	}
	for _, id := range vertragIds {
		err := data.AddVertragToUser(user, id)
		if err != nil {
			return nil, err
		}
	}
	vertragIDs, err := data.LoadVertragIds(user)
	if err != nil {
		return nil, err
	}
	return vertragIDs, nil
}

type stats struct {
	UniqueLogins         int
	UniqueLoginsByPortal map[string]int
}

func Stats(ctx context.Context) (stats, error) {
	n, err := data.UniqueLogins()
	if err != nil {
		return stats{}, err
	}
	byPortal, err := data.UniqueLoginsByPortal()
	if err != nil {
		return stats{}, err
	}

	return stats{
		UniqueLogins:         n,
		UniqueLoginsByPortal: byPortal,
	}, nil
}
