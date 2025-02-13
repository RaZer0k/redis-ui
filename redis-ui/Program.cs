using RedisUI;

var builder = WebApplication.CreateBuilder(args);

var app = builder.Build();
var host = Environment.GetEnvironmentVariable("REDIS_HOST") ?? "";
var port = Environment.GetEnvironmentVariable("REDIS_PORT") ?? "";

app.UseStaticFiles();
var options = new RedisUISettings { Path = "/" };
if (host != "" && port != "")
{
    options.ConnectionString = $"{host}:{port}";
}
app.UseRedisUI(options);

app.Run();