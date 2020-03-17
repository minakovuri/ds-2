FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /ds-2

# copy everything else and build app
COPY src/. .

# build BackendApi
WORKDIR /ds-2/BackendApi
RUN dotnet publish -c Release -o bin

# build Frontend
WORKDIR /ds-2/Frontend
RUN dotnet publish -c Release -o bin

# BackendApi runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS backend-api
WORKDIR /BackendApi
COPY --from=build /ds-2/BackendApi/bin ./
EXPOSE 5000
ENTRYPOINT ["dotnet", "BackendApi.dll"]

# Frontend runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS frontend
WORKDIR /Frontend
COPY --from=build /ds-2/Frontend/bin ./
EXPOSE 80
ENTRYPOINT ["dotnet", "Frontend.dll"]