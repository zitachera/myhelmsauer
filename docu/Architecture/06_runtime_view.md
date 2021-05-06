# Runtime View

## Schadenserfassung

```plantuml
skinparam monochrome true
skinparam shadowing false

Client -> Server: create Schadensmeldung
Client -> Server: add Text to Meldung
Client -> Server: add Image to Meldung
Client -> Server: send Meldung
```
