# Como Resolve?

Utilitário para encontrar soluções para problemas no [Python](https://www.python.org/).

## Instalação

Instale o pacote `comoresolve` através do [PyPI](https://pypi.org/project/comoresolve/). Exemplo:

```sh
pip install comoresolve
```

## Uso

Utilize o comando `comoresolve` como se fosse o interpretador do Python. Exemplo:

```sh
# Para:
python meu_arquivo.py
# Execute:
comoresolve meu_arquivo.py

# Para:
python -m meu_modulo
# Execute:
comoresolve -m meu_modulo
```

## Ambiente de desenvolvimento

O ambiente de desenvolvimento desse projeto pode ser construído automaticamente com [Dev Container](https://containers.dev/).

### Lints e tests

Os linters e testes desse projeto podem ser executados com:

```sh
make lint test
```

Para executá-los automaticamente no commit, execute os seguintes comandos:

```sh
cat << EOF > .git/hooks/pre-commit
#!/bin/sh

make lint test
EOF
chmod +x .git/hooks/pre-commit
```

### Formatar código

Para formatar o código do projeto automaticamente execute:

```sh
make fmt
```
