FROM eclipse-temurin:17-jdk-alpine

ARG user=appuser
ARG group=appuser

RUN addgroup -S appuser && adduser -S $user -G appuser

COPY *.jar app.jar

RUN chown -R $user:$user /home/$user/

RUN chmod -R 755 /home/$user/

EXPOSE 8080

WORKDIR /home/$user

ENTRYPOINT ["java","-jar","-Dspring.profiles.active=mysql","/app.jar"]
