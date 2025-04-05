package helpers

import (
	"crypto/hmac"
	"crypto/rand"
	"crypto/sha256"
	"encoding/base64"
	"encoding/hex"
	"fmt"
	"io"
	"math/big"

	"golang.org/x/crypto/bcrypt"
)

const SALT_COST = 11

func GenerateSalt(length int) (string, error) {
	salt := make([]byte, length)

	if _, err := io.ReadFull(rand.Reader, salt); err != nil {
		return "", err
	}
	return base64.StdEncoding.EncodeToString(salt), nil
}

func HashPassword(password string, salt string) (string, error) {
	saltedPassword := password + salt
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(saltedPassword), bcrypt.DefaultCost)

	if err != nil {
		return "", err
	}

	return string(hashedPassword), nil
}

func CheckPasswordHash(password, salt, hash string) bool {
	saltedPassword := password + salt
	err := bcrypt.CompareHashAndPassword([]byte(hash), []byte(saltedPassword))

	return err == nil
}

func GeneratePassword(minPasswordLength, maxPasswordLength int64) (string, error) {
	const passwordChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_=+[]{}|;:,.<>?/~`"

	length, err := rand.Int(rand.Reader, big.NewInt(maxPasswordLength-minPasswordLength+1))
	if err != nil {
		return "", err
	}

	length.Add(length, big.NewInt(minPasswordLength))

	password := make([]byte, length.Int64())

	for i := range password {
		index, err := rand.Int(rand.Reader, big.NewInt(int64(len(passwordChars))))
		if err != nil {
			return "", err
		}
		password[i] = passwordChars[index.Int64()]
	}

	return string(password), nil
}

func GenerateMAC(secretKey []byte, data string) []byte {
	h := hmac.New(sha256.New, secretKey)
	h.Write([]byte(data))

	return h.Sum(nil)
}

func VerifyMAC(secretKey []byte, data string, providedMAC []byte) bool {
	expectedMAC := GenerateMAC(secretKey, data)
	return hmac.Equal(expectedMAC, providedMAC)
}

func GenerateSecretKey() ([]byte, error) {
	// 256 bits
	key := make([]byte, 32)
	_, err := rand.Read(key)

	if err != nil {
		return nil, err
	}

	return key, nil
}

func GenerateCode() (string, error) {
	var part2Str string
	var alphanumericCharset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	var part1 = make([]byte, 4)

	if _, err := rand.Read(part1); err != nil {
		return "", err
	}

	part1Hex := hex.EncodeToString(part1)

	part2 := make([]byte, 3)

	if _, err := rand.Read(part2); err != nil {
		return "", err
	}

	for _, b := range part2 {
		part2Str += string(alphanumericCharset[b%byte(len(alphanumericCharset))])
	}

	return fmt.Sprintf("%s-%s", part1Hex[:4], part2Str), nil
}
