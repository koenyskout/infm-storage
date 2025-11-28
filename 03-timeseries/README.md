# Time series database oefeningen

## Setup

1. Open deze folder in VS Code.

2. Open een terminal (je zou in deze folder moeten staan)

3. Start alle Docker containers via
`docker compose up --build --watch`. Dit start 5 containers die met mekaar communiceren, namelijk
    - InfluxDB v2 (de time series database)
        * Hostname `influxdb`
        * username `admin`
        * password `password`
        * admintoken `password`
        * Luistert op poort `8086`
        * Admin interface bereikbaar via http://localhost:8086
    - mqtt-broker (een lokale Mosquitto MQTT broker)
        * Hostname `mqtt-broker`
        * Luistert op poort `1883`
    - mqtt-simulator (een Python-script dat data genereert en verstuurt naar de MQTT broker)
    - node-red, bereikbaar op http://localhost:1880
    - grafana (visualisatie), bereikbaar op http://localhost:3000

> Het --build argument zorgt ervoor dat, als je de python-code van de generator aanpast, de image elke opnieuw gebouwd wordt voor de container gestart wordt.

> Het --watch argument zorgt ervoor dat de mqtt-simulator opnieuw gestart wordt als je de bestanden (bv. configuratie) daarvan wijzigt.

Als je later opnieuw wil beginnen met een lege database,
- stop je de containers (Ctrl-C), `docker compose down`
- verwijder je de folder `influxdb2_data` die aangemaakt werd in de `data`-folder
- start je de database opnieuw (`docker compose up --build --watch`)

## Oefeningen

### Oefening 1

1. Surf naar [http://localhost:8086](http://localhost:8086) en login als `admin` met wachtwoord `password`.
2. Ga naar de 'Data Explorer' tab

3. Klik wat rond. Welke buckets, measurements, fields en tags zie je?

### Oefening 2

Maak (via de query editor) een query aan:
- begin bij de `timeseries` bucket
- filter op `climate` als measurement
- filter op `temperature` als field
- filter op `kitchen` als room
- zet de tijdperiode op de voorbije 15 minuten (via het klokje rechtsboven)
- zet aggregate function (in het venster rechts) op `Custom` en zet alle aggregatie-functies (bv. mean) **uit**.

Druk op submit. Je krijgt een grafiek met het resultaat van je query.

### Oefening 3

De ingebouwde data explorer van InfluxDB gebruikt Flux als query-taal.

Welke InfluxQL query komt overeen met bovenstaande vraag?

### Oefening 4

Open Node-RED (http://localhost:1880) en bekijk de flow. Hoe wordt de data vanuit MQTT naar de database gestuurd?

### Oefening 5
Bestudeer de query in de `influxdb in` node. Wat doet deze?
Voer de query uit door op de Inject-node te klikken.

### Oefening 6

Open Grafana (http://localhost:3000) en voeg InfluxDB als data source toe met volgende parameters.
- Query language: **InfluxQL**
- URL: http://influxdb:8086
- Database: timeseries
- User: admin
- Password: password

Klik op "Save & test".

### Oefening 7

In Grafana kunnen we wél met InfluxQL als query-taal werken. Grafana biedt hiervoor een visuele editor.

Ga naar de `Explore' tab en bouw een query die de temperatuur van de laatste 15 minuten teruggeeft, gegroepeerd per ruimte.

_Hint_: filteren op tijd doe je in Grafana via het klokje rechtsboven (daar kan je bv. ); niet rechtstreeks in de WHERE-clausule van je query.

### Oefening 8

Maak een query die alle gemeten luchtvochtigheidswaarden in de leefruimte teruggeeft van de laatste 30 minuten.

### Oefening 9

Maak een query die de gemiddelde luchtvochtigheid in de keuken teruggeeft van de laatste 30 minuten, berekend per periode van 1 minuut.

### Oefening 10

Maak een query die voor de voorbije 30 minuten het *moving average* van de temperatuur weergeeft per ruimte, telkens gebaseerd op de laatste 40 metingen.

### Oefening 11

Pas de query uit de vorige oefening aan zodat enkel de waarden voor de keuken en leefruimte teruggegeven worden.

### Oefening 12

Maak een query die, per 10 minuten van het voorbije uur, de maximale temperatuur teruggeeft over alle kamers heen.