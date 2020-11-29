[![MOCS](./header.svg)](https://mocs.euaaron.codes/)

## Sobre

MOCS, ou Menu and Order Control System, como o próprio nome diz é um sistema para controlar pedidos e exibir cardápios.

O sistema permirá que usuários cadastrados pesquisem estabelecimentos e vejam os pratos disponíveis. 

Todo usuário pode cadastrar um estabelecimento e vincular usuários à este estabelecimento como funcionários. 

O usuário que cadastra um estabelecimento, automáticamente é adicionado à lista de funcionários, com o nível de permissão 0 (nível dado à funcionários com cargos administrativos máximo).

## Níveis de Permissão

### Nível 5 - Profissioal de RH
- pode adicionar, alterar ou remover funcionários;

### Nível 4 - Cheff
- pode listar, adicionar, alterar e remover pratos;
- pode listar comandas e pedidos;

### Nível 3 - Garçom
- pode listar, adicionar e remover comandas;
- pode listar, adicionar e remover pedidos de comandas;

### Nível 2 - Supervisor
- todas as permissões do nível 3;
- pode alterar pratos;
- pode alterar comandas;
- pode alterar pedidos de comandas;

### Nível 1 - Gerente Geral 
- todas as permissões anteriores;
- pode adicionar, alterar ou remover funcionários;

### Nível 0 - Administrador 
- todas as permissões anteriores;
- pode adicionar funcionários com nível de permissão 0;
- pode alterar e deletar o estabelecimentos do sistema.

Para dúvidas ou sugestões, deixe um [issue]().
