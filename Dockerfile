FROM eclipse-temurin:17-jdk-jammy
WORKDIR /javaprg
COPY Main.java .
RUN javac Main.java
CMD ["java", "Main.java"]
