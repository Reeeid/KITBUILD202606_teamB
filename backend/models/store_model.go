package models

type Store struct {
	Id          uint
	Name        string
	KanaName    string
	Description string
	Lat         float64
	Lng         float64
	IsCheap     bool
}
