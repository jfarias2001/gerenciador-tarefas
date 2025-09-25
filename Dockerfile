# --- Estágio 1: Build ---
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

# Copia o código-fonte
COPY . .

# Compila o projeto, gera o .jar (sem rodar testes para agilizar)
RUN mvn -B package -DskipTests


# --- Estágio 2: Runtime ---
FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

# Copia o .jar gerado no estágio anterior
COPY --from=builder /app/target/*.jar app.jar

# Expõe a porta padrão do Spring Boot
EXPOSE 8080

# Comando de inicialização
ENTRYPOINT ["java", "-jar", "app.jar"]
