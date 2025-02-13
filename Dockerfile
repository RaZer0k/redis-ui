FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
LABEL name="redis-ui"
ENV REDIS_HOST=127.0.0.1
ENV REDIS_PORT=6379
USER app
WORKDIR /app
EXPOSE 8080

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["redis-ui/redis-ui.csproj", "redis-ui/"]
RUN dotnet restore "./redis-ui/redis-ui.csproj"
COPY . .
WORKDIR "/src/redis-ui"
RUN dotnet build "./redis-ui.csproj" -c $BUILD_CONFIGURATION -o /app/build

FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "./redis-ui.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "redis-ui.dll"]