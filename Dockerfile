FROM mcr.microsoft.com/dotnet/sdk:8.0-jammy AS build

WORKDIR /build/src
COPY ./src/Calculator.sln ./
COPY ./src/Calculator/Calculator.csproj ./Calculator/
COPY ./src/Calculator.TUnit.Tests/Calculator.TUnit.Tests.csproj ./Calculator.TUnit.Tests/
COPY ./src/Calculator.XUnit.Tests/Calculator.XUnit.Tests.csproj ./Calculator.XUnit.Tests/
RUN dotnet restore Calculator.sln --runtime=linux-x64
COPY ./src .

FROM mcr.microsoft.com/dotnet/sdk:8.0-jammy AS test

WORKDIR /build
COPY --from=build ./build/src ./src
RUN mkdir ./test-results

SHELL ["/bin/bash", "-c"]
CMD dotnet test \
    --blame \
    --blame-hang-timeout 5min \
    --logger:trx \
    --logger:"GitHubActions;report-warnings=false" \
    --logger:"console;verbosity=normal" \
    --results-directory "/build/test-results" \
    /build/src/Calculator.sln \
    -- --report-trx --results-directory "/build/test-results"