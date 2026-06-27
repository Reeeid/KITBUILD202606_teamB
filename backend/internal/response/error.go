package response

import (
	"github.com/gin-gonic/gin"
)

func ErrorResponse(r *gin.Context, http_status_code int, message string, err error) {
	r.JSON(http_status_code, gin.H{
		"http_status_code": http_status_code,
		"message":          message,
		"error":            err,
	})
}
