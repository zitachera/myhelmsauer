package data

import (
	"testing"

	"github.com/stretchr/testify/require"
)

func openInMemory() error {
	return Open(":memory:")
}

func TestOpen(t *testing.T) {
	require.NoError(t, openInMemory())
}
