# Imagem mínima do Alpine Linux com Golang
FROM golang:alpine AS build

WORKDIR /go/src/app
COPY . .

# Compilar o código Go
# -s remove informações de depuração
# -w remove informações sobre símbolos de depuração e otimizações DWARF
RUN go build -ldflags "-s -w" -o app

# Imagem completamente vazia, sem SO ou lib
FROM scratch

# Copia somente o binário
COPY --from=build /go/src/app/app /

# Comando padrão a ser executado quando a imagem for iniciada
CMD ["/app"]
