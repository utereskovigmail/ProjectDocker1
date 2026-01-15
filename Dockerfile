# Stage 1: Build stage
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /source

# Копіюємо проект і відновлюємо залежності
COPY ["Project1/Project1.csproj", "Project1/"]
RUN dotnet restore "Project1/Project1.csproj"

# Копіюємо всі файли і будуємо додаток
COPY . .
WORKDIR /source/Project1
RUN dotnet publish -c Release -o /app

# Stage 2: Final image for runtime
FROM mcr.microsoft.com/dotnet/aspnet:9.0

WORKDIR /app

# Копіюємо додаток з етапу побудови
COPY --from=build /app .

# Запускаємо додаток
ENTRYPOINT ["dotnet", "Project1.dll"]
