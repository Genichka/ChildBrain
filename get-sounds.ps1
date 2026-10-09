# Справжні записи тварин для Гралика (42 тварини).
# Джерела: bigsoundbank.com (CC0), nps.gov і U.S. Fish & Wildlife Service (суспільне надбання),
# soundbible.com (суспільне надбання або CC BY 3.0 - автори вказані в README і в грі).
# Запускати з теки, де лежить index.html. Потім залити папку sounds у репозиторій.
$ErrorActionPreference = 'Stop'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$list = [ordered]@{
  cow = @('https://bigsoundbank.com/UPLOAD/mp3/2383.mp3')
  dog = @('https://bigsoundbank.com/UPLOAD/mp3/2955.mp3')
  cat = @('https://bigsoundbank.com/UPLOAD/mp3/1890.mp3')
  sheep = @('https://bigsoundbank.com/UPLOAD/mp3/2343.mp3')
  frog = @('https://bigsoundbank.com/UPLOAD/mp3/0819.mp3')
  hen = @('https://bigsoundbank.com/UPLOAD/mp3/0453.mp3')
  rooster = @('https://bigsoundbank.com/UPLOAD/mp3/0283.mp3')
  duck = @('https://bigsoundbank.com/UPLOAD/mp3/0276.mp3')
  horse = @('https://bigsoundbank.com/UPLOAD/mp3/0284.mp3')
  mouse = @('https://bigsoundbank.com/UPLOAD/mp3/0459.mp3')
  owl = @('https://bigsoundbank.com/UPLOAD/mp3/3459.mp3')
  goat = @('https://bigsoundbank.com/UPLOAD/mp3/0279.mp3')
  donkey = @('https://bigsoundbank.com/UPLOAD/mp3/1550.mp3')
  bee = @('https://bigsoundbank.com/UPLOAD/mp3/1000.mp3')
  crow = @('https://bigsoundbank.com/UPLOAD/mp3/3463.mp3')
  cricket = @('https://bigsoundbank.com/UPLOAD/mp3/1020.mp3')
  chick = @('https://bigsoundbank.com/UPLOAD/mp3/0430.mp3')
  parrot = @('https://bigsoundbank.com/UPLOAD/mp3/2774.mp3')
  nightingale = @('https://bigsoundbank.com/UPLOAD/mp3/3087.mp3')
  fly = @('https://bigsoundbank.com/UPLOAD/mp3/0759.mp3')
  bear = @('https://soundbible.com/grab.php?id=241&type=mp3')
  fox = @('https://www.nps.gov/nps-audiovideo/legacy/mp3/imr/avElement/yell-YELLMJ23200837redfox.mp3')
  squirrel = @('https://www.nps.gov/nps-audiovideo/legacy/mp3/imr/avElement/yell-YELLSGYredsquirrel2004320.mp3', 'https://www.nps.gov/nps-audiovideo/legacy/mp3/nri/avElement/nri-SquirrelYELL.mp3')
  lion = @('https://soundbible.com/grab.php?id=1272&type=mp3', 'https://soundbible.com/grab.php?id=1282&type=mp3')
  elephant = @('https://soundbible.com/grab.php?id=1136&type=mp3', 'https://soundbible.com/grab.php?id=1140&type=mp3')
  monkey = @('https://soundbible.com/grab.php?id=1188&type=mp3')
  tiger = @('https://soundbible.com/grab.php?id=1485&type=mp3')
  goose = @('https://www.nps.gov/nps-audiovideo/legacy/mp3/nri/avElement/nri-CanadaGoose.mp3', 'https://soundbible.com/grab.php?id=1202&type=mp3')
  turkey = @('https://www.nps.gov/nps-audiovideo/legacy/mp3/imr/avElement/romo-WITUROMO5192016AlluvialFan.mp3', 'https://www.nps.gov/nps-audiovideo/legacy/mp3/imr/avElement/romo-WITU2ROMO5192016AlluvialFan.mp3')
  dove = @('https://soundbible.com/grab.php?id=1850&type=mp3')
  mosquito = @('https://soundbible.com/grab.php?id=398&type=mp3')
  deer = @('https://www.nps.gov/nps-audiovideo/legacy/mp3/nri/avElement/nri-ElkBuglingGRSA.mp3', 'https://soundbible.com/grab.php?id=957&type=mp3')
  eagle = @('https://www.nps.gov/nps-audiovideo/legacy/mp3/nri/avElement/nri-BaldEagleYELL.mp3', 'https://soundbible.com/grab.php?id=981&type=mp3')
  swan = @('https://soundbible.com/grab.php?id=275&type=mp3')
  whale = @('https://www.nps.gov/nps-audiovideo/legacy/mp3/nri/avElement/nri-HumpbackGLBA.mp3')
  seal = @('https://soundbible.com/grab.php?id=142&type=mp3', 'https://www.nps.gov/nps-audiovideo/audiovideo/c014d5aa-ed06-4d04-9f12-517fd2041065.mp3')
  crocodile = @('https://www.nps.gov/nps-audiovideo/legacy/mp3/nri/avElement/nri-AlligatorEVER1.mp3')
  snake = @('https://soundbible.com/grab.php?id=237&type=mp3')
  gorilla = @('https://soundbible.com/grab.php?id=1149&type=mp3', 'https://soundbible.com/grab.php?id=1147&type=mp3')
  bison = @('https://www.nps.gov/nps-audiovideo/legacy/mp3/imr/avElement/yell-YELLMM8K2005914Bison.mp3', 'https://www.nps.gov/nps-audiovideo/legacy/mp3/nri/avElement/nri-BisonYELL.mp3')
  bat = @('https://www.nps.gov/nps-audiovideo/legacy/mp3/nri/avElement/nri-SpottedBatYOSE.mp3', 'https://soundbible.com/grab.php?id=238&type=mp3')
  peacock = @('https://soundbible.com/grab.php?id=1430&type=mp3', 'https://soundbible.com/grab.php?id=1443&type=mp3')
}
New-Item -ItemType Directory -Force -Path sounds | Out-Null
$ok = 0
foreach ($k in $list.Keys) {
  $f = Join-Path 'sounds' "$k.mp3"
  $done = $false
  foreach ($u in $list[$k]) {
    try {
      Invoke-WebRequest $u -OutFile $f -UseBasicParsing -UserAgent 'Mozilla/5.0'
      if ((Get-Item $f).Length -lt 2000) { throw 'файл замалий' }
      '{0,-12} {1,9:N0} байт' -f $k, (Get-Item $f).Length
      $ok++; $done = $true; break
    } catch {
      Remove-Item $f -ErrorAction SilentlyContinue
    }
  }
  if (-not $done) { '{0,-12} не вдалося (гра візьме запис з інтернету або синтез)' -f $k }
}
""
"Готово: $ok з $($list.Count). Тепер залийте папку sounds у репозиторій поруч з index.html."
