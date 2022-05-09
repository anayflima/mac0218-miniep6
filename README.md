# Miniep6 - MAC0218
MiniEP6 da matéria MAC0218 - Técnicas de Programação II.
Aplicação do docker.

## Parte 1 - Criando sua própria imagem

Primeiro, para construir a imagem do `CADDY`, foi necessário criar o `Caddyfile`, que contém a configuração do servidor e um arquivo `Dockerfile`, que mostra as etapas que o Docker precisa seguir para preparar a imagem.

Em seguida, podemos fazer a construção da imagem. Pegamos a versão mais nova disponibilizada no [Docker Hub](https://hub.docker.com/_/caddy?tab=description):

`sudo docker image build . -t custom-caddy:2.5.1-alpine`

Depois da construção, podemos rodar a imagem. Escolhemos ligar a porta do contêiner (80) com a porta 8080, uma porta alta no host:

`sudo docker container run --name my-caddy-server -p 8080:80 -d custom-caddy:2.5.1-alpine`

Dessa forma, teremos a imagem do `CADDY` rodando. Para visualizar o conteúdo do `HTML` podemos ou abrir o arquivo num navegador web ou executar o seguinte comando no terminal:

`curl http://localhost:8080`

Com essa imagem, para atualizar o conteúdo das páginas `HTML`, é preciso reconstruir a imagem. Isso foi testado fazendo-se uma alteração no `HTML`. O conteúdo mostrado com o comando `curl` permanecia o mesmo. Foi preciso executar os seguintes comandos para fazer as atualizações:

`sudo docker container stop my-caddy-server`

`sudo docker container rm my-caddy-server`

E fazer o `build` novamente.

## Parte 2 - Potencializando nosso Servidor para desenvolvimento

No Docker Hub do `CADDY`, na seção *Basic Usage*, é apresentada a possibilidade de se ligar arquivos ou pastas usados na imagem com o diretório atual. Dessa forma, alterações feitas nesse diretório serão atualizadas na imagem diretamente, sem que seja preciso construir uma nova imagem. Isso é feito pela flag `-v`:

`sudo docker container run --name my-caddy-server -p 8080:80 -v $PWD/pages:/usr/src/pages -d custom-caddy:2.5.1-alpine`

Para testar, foram feitas outras alterações no HTML, que puderam ser vistas na imagem sem que fosse preciso reconstruí-la.

Finalmente, foram rodados os comandos de `stop` e `rm` para, respectivamente, parar a execução da imagem e removê-la.