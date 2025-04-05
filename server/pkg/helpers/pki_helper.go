package helpers

import (
	"crypto/rand"
	"crypto/rsa"
	"crypto/sha256"
	"crypto/x509"
	"encoding/base64"
	"encoding/json"
	"encoding/pem"
	"errors"
	"fmt"
	"math/big"
	"os"
	"path"
)

const (
	PKI_PATH       = "www/keys"
	WELL_KWOWN     = "www/.well-known"
	JWKS_FILE_NAME = "jwks.json"
	KeyBits        = 2048
)

var (
	private_key_path = PKI_PATH + "/" + "private.pem"
	public_key_path  = PKI_PATH + "/" + "public.pem"

	ErrFailedToReadJWKS = errors.New("failed to read JWKS file")
	ErrUnmarshalJWKS    = errors.New("failed to unmarshal JWKS data")
	ErrFailedToOpenKey  = errors.New("failed to open file for writing key")
)

type (
	KeyPair struct {
		PrivateKey *pem.Block
		PublicKey  *pem.Block
	}

	JWKS struct {
		Keys []JWK `json:"keys"`
	}

	JWK struct {
		Kty string `json:"kty"`
		Kid string `json:"kid"`
		Use string `json:"use"`
		N   string `json:"n"`
		E   string `json:"e"`
		Alg string `json:"alg"`
	}
)

var storedJwks *JWKS

func MustCreatePKI() bool {
	return keysDirExists(PKI_PATH)
}

func ReadKeys() ([]byte, []byte, error) {
	privKey, err := os.ReadFile(private_key_path)

	if err != nil {
		return nil, nil, err
	}

	pubKey, err := os.ReadFile(public_key_path)

	if err != nil {
		return nil, nil, err
	}

	return privKey, pubKey, nil
}

func base64URLUInt(i *big.Int) string {
	return base64.RawURLEncoding.EncodeToString(i.Bytes())
}

func loadJWKS(jwksPath string) (*JWKS, error) {
	if storedJwks != nil {
		return storedJwks, nil
	}

	openJwksFile, err := os.ReadFile(jwksPath)
	if err != nil {
		return nil, ErrFailedToReadJWKS
	}

	var jwksData JWKS

	err = json.Unmarshal(openJwksFile, &jwksData)

	if err != nil {
		return nil, ErrUnmarshalJWKS
	}

	storedJwks = &jwksData
	return &jwksData, nil
}

func storeJwks(jwks *JWKS, jwksPath string) error {
	jwksFile, err := os.Create(jwksPath)

	if err != nil {
		return err
	}

	defer jwksFile.Close()

	jwksMarshal, err := json.Marshal(jwks)

	if err != nil {
		return err
	}

	_, err = jwksFile.Write(jwksMarshal)

	if err != nil {
		panic(err)
	}

	return nil
}

func generateKid() string {
	pubKeyBytes := x509.MarshalPKCS1PublicKey(PubKey)
	return fmt.Sprintf("%x", sha256.Sum256(pubKeyBytes))
}

func CreateJWKS() (*JWKS, error) {
	var jwks *JWKS

	jwk := JWK{
		Kty: "RSA",
		Kid: generateKid(),
		N:   base64URLUInt(PubKey.N),
		E:   base64URLUInt(big.NewInt(int64(PubKey.E))),
		Use: "sig",
		Alg: "RS256",
	}

	jwks = &JWKS{
		Keys: []JWK{jwk},
	}

	storedJwks = jwks
	return jwks, nil
}

func NewJWKS() (*JWKS, error) {
	jwksPath := path.Join(WELL_KWOWN, JWKS_FILE_NAME)

	if !keysDirExists(WELL_KWOWN) {
		if err := os.MkdirAll(WELL_KWOWN, 0755); err != nil {
			return nil, err
		}
	}

	jwks, err := loadJWKS(jwksPath)

	if err == nil {
		return jwks, nil
	}

	jwks, err = CreateJWKS()

	if err != nil {
		return nil, err
	}

	if err := storeJwks(jwks, jwksPath); err != nil {
		return nil, err
	}

	return jwks, nil
}

func GenerateServerPKI() error {
	if !keysDirExists(PKI_PATH) {
		if err := os.MkdirAll(PKI_PATH, 0755); err != nil {
			return err
		}
	}

	keys, err := CreatePKI()

	if err != nil {
		return err
	}

	if err := saveKey(keys.PrivateKey, private_key_path); err != nil {
		return err
	}

	if err := saveKey(keys.PublicKey, public_key_path); err != nil {
		return err
	}

	return nil
}

func keysDirExists(path string) bool {
	info, err := os.Stat(path)

	if err != nil {
		return false
	}

	return info.IsDir()
}

func saveKey(key *pem.Block, filePath string) error {
	keyFile, err := os.Create(filePath)

	if err != nil {
		return ErrFailedToOpenKey
	}

	defer keyFile.Close()

	return pem.Encode(keyFile, key)
}

func EncryptPK(secretKey []byte) ([]byte, error) {
	encryptedKey, err := rsa.EncryptOAEP(sha256.New(), rand.Reader, PubKey, secretKey, nil)

	if err != nil {
		return nil, fmt.Errorf("failed to encrypt secret key: %v", err)
	}

	return encryptedKey, nil
}

func DecryptWithPrivateKey(encryptedKey []byte) ([]byte, error) {
	secretKey, err := rsa.DecryptOAEP(sha256.New(), rand.Reader, privKey, encryptedKey, nil)

	if err != nil {
		return nil, fmt.Errorf("failed to decrypt secret key: %v", err)
	}

	return secretKey, nil
}

func CreatePKI() (*KeyPair, error) {
	privateKey, err := rsa.GenerateKey(rand.Reader, KeyBits)

	if err != nil {
		return nil, err
	}

	privateKeyPEM := &pem.Block{
		Type:  "RSA PRIVATE KEY",
		Bytes: x509.MarshalPKCS1PrivateKey(privateKey),
	}

	publicKeyPEM := &pem.Block{
		Type:  "RSA PUBLIC KEY",
		Bytes: x509.MarshalPKCS1PublicKey(&privateKey.PublicKey),
	}

	return &KeyPair{
		PrivateKey: privateKeyPEM,
		PublicKey:  publicKeyPEM,
	}, nil
}
