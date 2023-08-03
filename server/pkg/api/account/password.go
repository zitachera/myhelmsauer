package account

import (
	"context"

	"gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/api/auth"
	"gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/api/handle"
	"gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/data"
)

type ChangePasswordRequest struct {
	OldPassword string `json:"oldPassword"`
	NewPassword string `json:"newPassword"`
}

func ChangePassword(ctx context.Context, request ChangePasswordRequest) (struct{}, error) {
	c := auth.GetClient(ctx)

	if c.SubAccount != "" {

		if auth.PassHash(request.OldPassword) != c.PasswordHash {
			return struct{}{}, handle.Errorf(400, "Die Angabe Ihres aktuellen Passworts ist inkorrekt.")
		}

		c.PasswordHash = auth.PassHash(request.NewPassword)

		return struct{}{}, data.UpdateSubCredentials(c)
	}

	if request.OldPassword != c.Password {
		return struct{}{}, handle.Errorf(400, "Die Angabe Ihres aktuellen Passworts ist inkorrekt.")
	}

	if err := c.ChangePassword(request.NewPassword); err != nil {
		return struct{}{}, err
	}
	c.Password = request.NewPassword

	return struct{}{}, data.UpdateCredentials(c)
}
