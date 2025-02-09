# 🏨 **Guia Motéis**
_Um guia completo de motéis, suítes e preços na sua região._

---

## 📌 **Sobre o Projeto**
O **Guia Motéis** é um aplicativo desenvolvido em **Flutter** para facilitar a busca por motéis, permitindo que os usuários vejam **suítes, preços e avaliações** de diferentes estabelecimentos.

Os dados são obtidos a partir da API [JSONKeeper](https://www.jsonkeeper.com/b/1IXK), garantindo informações atualizadas e organizadas.

---

## 📲 **Funcionalidades**
✔️ Listagem de motéis com **nome, bairro, avaliação e número de reviews**.  
✔️ Exibição de **suítes disponíveis** dentro de cada motel.  
✔️ Visualização de **valores e descontos**.  
✔️ **Gerenciamento de estado** com Flutter BLoC.

---

## 🏗 **Tecnologias Utilizadas**
- **Flutter (Dart)**
- **BLoC** para gerenciamento de estado
- **Equatable** para comparações eficientes
- **HTTP** para requisições à API
- **Mockito & Bloc Test** para testes unitários e de integração

---

## 🚀 **Como Instalar e Rodar o Projeto**

### **1️⃣ Pré-requisitos**
Antes de começar, você precisa ter:
- **Flutter** instalado → [Guia de Instalação](https://flutter.dev/docs/get-started/install)
- **Dart SDK** instalado → [Instalar Dart](https://dart.dev/get-dart)
- **Editor de código** (VS Code ou Android Studio)

### **2️⃣ Clonar o Repositório**
Abra o terminal e execute:
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

Caso queira rodar em um emulador específico:
```sh
flutter run -d <ID_DO_DISPOSITIVO>
```
Para listar os dispositivos disponíveis:
```sh
flutter devices
```

---

## 🔍 **Estrutura do Projeto**
```sh
lib/
│── core/
│   ├── network/         # Cliente HTTP e configuração de API
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
│── main.dart                  # Ponto de entrada do app
```

---

## ✅ **Executando Testes**
Para rodar todos os testes da aplicação com mais detalhes no console:
```sh
flutter test --reporter=expanded
```
Caso queira rodar apenas os testes de uma pasta ou arquivo específico:
```sh
flutter test test/features/motels/
```
Para um único teste:
```sh
flutter test test/features/motels/presentation/bloc/motel_bloc_test.dart
```

---

Desenvolvido por **Adriano Júnior** 💙🚀