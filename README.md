# 🏨 **Guia Moteis**
_Um guia completo de motéis, suítes e preços na sua região._

---

## 📌 **Sobre o Projeto**
O **Guia Moteis** é um aplicativo Flutter que permite aos usuários encontrar motéis, visualizar suítes disponíveis e verificar preços detalhados.  
Os dados são obtidos a partir da API [JSONKeeper](https://www.jsonkeeper.com/b/1IXK) e organizados para facilitar a navegação.

---

## 📲 **Funcionalidades**
✔️ Listagem de motéis com **nome, logo, bairro, avaliação e número de reviews**.  
✔️ Exibição de **suítes disponíveis** dentro de cada motel.  
✔️ Visualização de **valores e descontos**.  

---

## 🏗 **Tecnologias Utilizadas**
- **Flutter (Dart)**
- **Flutter BLoC** para gerenciamento de estado
- **Equatable** para comparações eficientes
- **HTTP** para requisições à API
- **Mockito & Bloc Test** para testes unitários e de BLoC

---

## 🚀 **Como Instalar e Rodar o Projeto**

### **1️⃣ Pré-requisitos**
- Instalar o [Flutter](https://flutter.dev/docs/get-started/install) (versão 3.x ou superior)
- Instalar o [Dart](https://dart.dev/get-dart)
- Ter um editor de código (Android Studio / VS Code)

### **2️⃣ Clonar o Repositório**
```sh
git clone https://github.com/AdrianoJunior/GuiaMoteis.git
cd GuiaMoteis
```

### **3️⃣ Instalar as Dependências**
```sh
flutter pub get
```

### **4️⃣ Executar o App**
```sh
flutter run
```

---

## 🔍 **Estrutura do Projeto**
```
lib/
│── core/
│   ├── data/
│   │   ├── network/          # Clientes API
│── features/
│   ├── motels/
│   │   ├── data/
│   │   │   ├── repositories/  # Repositórios de dados
│   │   │   ├── models/        # Modelos de dados
│   │   ├── domain/
│   │   │   ├── entities/      # Entidades principais
│   │   │   ├── use_cases/     # Casos de uso
│   │   ├── presentation/
│   │   │   ├── bloc/          # Gerenciamento de estado com BLoC
│   │   │   ├── pages/         # Páginas da aplicação
│   │   │   ├── widgets/       # Componentes reutilizáveis
│── main.dart                   # Ponto de entrada do app
```

---

## ✅ **Executando Testes e Verificando Cobertura de Código**
Para rodar os testes unitários:
```sh
flutter test
```
Para gerar um relatório de cobertura de testes:
```sh
flutter test --coverage
genhtml coverage/lcov.info --output-directory=coverage/html
start coverage/html/index.html
```