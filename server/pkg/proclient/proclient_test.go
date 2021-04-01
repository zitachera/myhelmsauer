package proclient

import (
	"testing"
)

var client = Client{
	User:     "Demokunde",
	Password: "Demo90443HK",
}

func TestGetVertrage(t *testing.T) {
	got, err := client.GetVertraege()
	if err != nil {
		t.Errorf("GetVertrage() error = %v", err)
		return
	}
	// if !reflect.DeepEqual(got, tt.want) {
	// 	t.Errorf("GetVertrage() = %v, want %v", got, tt.want)
	// }
	t.Fatalf("%v", got)
}
