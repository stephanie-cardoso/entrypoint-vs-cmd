# Diferença entre ENTRYPOINT e CMD - Dockerfile

Enquanto fazia algumas alterações em um Dockerfile para subir uma app no k8s, precisei entender com mais detalhes a diferença entre ENTRYPOINT e CMD. Como essa é uma dúvida bem comum, resolvi criar essa um dockerfile para exemplificar a diferença e facilitar o entendimento.

### ENTRYPOINT

O ENTRYPOINT é o comando do seu container. Ele deve ser usado para definir o executável do seu container.

### CMD

São os argumentos do comando do seu container. Dentro do dockerfile, você pode definir os argumentos padrão. Caso seja necessário passar outro argumento em algum momento, não há problema. Nesse caso, os argumentos serão substituídos.

## Exemplo

Para melhor entendimento, faça os seguintes passos.

- Faça build da imagem desse repositório: `docker build -t ping .`
- Rode a imagem: `docker run ping`

Seguindo esses passos, você verá que ao rodar o container, o ping (ENTRYPOINT) já roda direto com o argumento passado no dockerfile (CMD), conforme esperado.

Agora faça o seguinte. Rode novamente a imagem mas agora passando outro endereço para o ping: `docker run ping globo.com`

Repare que nesse caso, o CMD é substituído pelo argumento passado no docker run.

### Somente ENTRYPOINT

Outra opção é você criar uma imagem somente com o ENTRYPOINT, pois esse é o executável do seu container. Para simular com a imagem do repositório, faça os seguintes passos:

- Remova a linha 7 do dockerfile `CMD [ "google.com" ]`
- Faça build novamente da imagem: `docker build -t ping .`
- Rode a imagem: `docker run ping`

Repare que nesse caso, o comando não roda. Você receberá o erro `ping: usage error: Destination address required`. Pois o ping precisa de um argumento.

Você deve então rodar a imagem passando o endereço para o ping junto com o comando: `docker run ping google.com`

### Somente CMD

Você pode também usar somente o CMD, não ter o ENTRYPOINT definido. No caso desse exemplo, você pode fazer:

- Remova a linha 6 do ENTRYPOINT
- Ajuste o CMD para rodar o comando e o argumento: `CMD [ "ping", "google.com" ]`

Nesse caso, vai rodar da mesma forma.

## Quando usar cada um?

Não é que exista uma forma certa ou errada de utilizar o ENTRYPOINT com ou sem CMD, ou somente o ENTRYPOINT.

Caso você queira "obrigar" que um comando seja executado no seu container, é recomendável usar o ENTRYPOINT. Pois o comando rodará com certeza (e os argumentos são opcionais).

Avalie o que faz sentido para o contexto da sua aplicação e faça sua decisão!