package response

import (
	"github.com/gin-gonic/gin"
)

func SuccessResponse(r *gin.Context, data any) {
	r.JSON(200, gin.H{
		"message": "success",
		"data":    data,
	})
}
