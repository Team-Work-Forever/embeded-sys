package helpers

import (
	"encoding/base64"
	"errors"
	"log"
)

var (
	ErrCreatingSecret   = errors.New("Error creating the secret")
	ErrEncryptingSecret = errors.New("Error encryting the key")
)

func CreateSecrets(plate string) (string, string, error) {
	secretKey, err := GenerateSecretKey()

	if err != nil {
		return "", "", ErrCreatingSecret
	}

	mac := GenerateMAC(secretKey, plate)

	secretKey, err = EncryptPK(secretKey)

	if err != nil {
		return "", "", ErrEncryptingSecret
	}

	mac64 := base64.StdEncoding.EncodeToString(mac)
	secret64 := base64.StdEncoding.EncodeToString(secretKey)

	return mac64, secret64, nil
}

func CheckSecrets(plate, secretKey64, expectedMac64 string) bool {
	mac, err := base64.StdEncoding.DecodeString(expectedMac64)

	if err != nil {
		log.Println("Error while converting back to bytes")
		return false
	}

	secreKeyDecoded, err := base64.StdEncoding.DecodeString(secretKey64)

	if err != nil {
		log.Println("Error converting secretkey to bytes")
		return false
	}

	secretKey, err := DecryptWithPrivateKey(secreKeyDecoded)

	if err != nil {
		log.Println("Error decrypting key using the servers private key")
		return false
	}

	return VerifyMAC(secretKey, plate, mac)
}
