package utils

import (
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"
)

func CreateItem(r *gin.Context, target any) {
	if err := r.ShouldBindJSON(&target); err != nil {
		r.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	fmt.Println(target)
}
