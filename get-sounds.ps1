# Справжні записи тварин для Гралика.
# Джерело - bigsoundbank.com, ліцензія CC0 (суспільне надбання).
# Запускати з теки, де лежить index.html. Потім залити папку sounds у репозиторій.
$ErrorActionPreference = 'Stop'
$list = [ordered]@{
  cow = '2383'; dog = '2955'; cat = '1890'; sheep = '2343'; frog = '0819'
  hen = '0453'; rooster = '0283'; duck = '0276'; horse = '0284'; mouse = '0459'
  owl = '3459'; goat = '0279'; donkey = '1550'; bee = '1000'; crow = '3463'
  cricket = '1020'; chick = '0430'; parrot = '2774'; nightingale = '3087'; fly = '0759'
}
New-Item -ItemType Directory -Force -Path sounds | Out-Null
$ok = 0
foreach ($k in $list.Keys) {
  $u = "https://bigsoundbank.com/UPLOAD/mp3/$($list[$k]).mp3"
  $f = Join-Path 'sounds' "$k.mp3"
  try {
    Invoke-WebRequest $u -OutFile $f -UseBasicParsing
    '{0,-12} {1,9:N0} байт' -f $k, (Get-Item $f).Length
    $ok++
  } catch {
    '{0,-12} не вдалося: {1}' -f $k, $_.Exception.Message
  }
}
""
"Готово: $ok з $($list.Count). Тепер залийте папку sounds у репозиторій поруч з index.html."
