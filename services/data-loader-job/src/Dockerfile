FROM mcr.microsoft.com/dotnet/sdk:3.1.412-buster-arm64v8 AS buildimage
WORKDIR /src
COPY ["Data.Loader.Job.csproj", "."]
RUN dotnet restore "Data.Loader.Job.csproj"
COPY . .
RUN dotnet build "Data.Loader.Job.csproj" -c Release -o /app/build

#Image to run app in Macbook wth M1 chip
FROM mcr.microsoft.com/dotnet/runtime:3.1.18-alpine3.13-arm64v8 AS runtimeimage
WORKDIR /app
COPY --from=buildimage /app/build .
ENTRYPOINT ["dotnet", "Data.Loader.Job.dll"]