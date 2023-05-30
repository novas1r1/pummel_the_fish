# Flutter für Dummies - Pummel The Fish
In diesem Repository befindet sich der Quellcode für die Beispiel-App "Pummel The Fish" aus dem Buch "Flutter für Dummies" von Mira Jago und Verena Zaiser. Der Zustand des Codes ist pro relevantem Kapitel in einem eigenen Ordner abgelegt. Die Benennung folgt dem Schema TxKy, wobei x für den Teil und y für das Kapitel steht.

Im Ordner `start_pummel_the_fish` finden Sie außerdem den Code, der im Buch als Ausgangspunkt für die App verwendet wird. 

Der Code ist auf [GitHub](https://github.com/novas1r1/pummel_the_fish) sowie auf der [offiziellen Wiley Seite](https://wiley-vch.de/ISBN9783527720293) verfügbar. Auf GitHub werden wir den Code regelmäßig anpassen, um ihn auf dem neuesten Stand zu halten. Außerdem können Sie dort auch die einzelnen Versionen des Codes herunterladen und Fragen stellen. Eine vollständig getestete Code-Base werden Sie dort ebenfalls vorfinden.

Wir wünschen Ihnen viel Spaß beim Lesen und Programmieren!
Verena Zaiser und Mira Jago

## Wichtige Informationen
Die im Buch verwendete Flutter-Version ist `3.7.11`. Die in diesem Code-Beispiel verwendete Flutter-Version ist `3.10.1`. Sollte diese Version veraltet sein, wenn Sie das Buch lesen, greifen Sie bitte auf den Code im [GitHub Repository](https://github.com/novas1r1/pummel_the_fish) zurück. Dort haben wir die Möglichkeit Anpassungen vorzunehmen und werden den Code auf dem aktuellen Stand halten und gegebenfalls mit Kommentaren versehen.

Wenn Sie mit Firebase arbeiten wollen, müssen Sie Ihr eigenes Projekt in der Firebase Console anlegen und in diesem Projekt konfigurieren. Wie das funktioniert erfahren Sie in Teil 4, Kapitel 17. Die `firebase_options.dart` Datei im `lib`-Ordner wird benötigt, um sich dann auf Ihr Firebase Projekt zu verbinden.

## Potenzielle Bugs & Fehlermeldungen
Wir haben hier einige Fehler gesammelt, die Ihnen beim Programmieren unterkommen könnten - speziell dann, wenn Sie Ihre Flutter Version updaten. Diese Liste wird im GitHub Repository erweitert, sollte es zu neuen Fehlern mit neuen Flutter oder Package-Versionen kommen.

### Fehler beim Starten der App
Beim Starten der App tritt der folgende Fehler in der Debug Console auf:

#### Fehlermeldung:
```
FAILURE: Build failed with an exception.

* What went wrong:
Execution failed for task ':app:mapDebugSourceSetPaths'.
> Error while evaluating property 'extraGeneratedResDir' of task ':app:mapDebugSourceSetPaths'
   > Failed to calculate the value of task ':app:mapDebugSourceSetPaths' property 'extraGeneratedResDir'.
      > Querying the mapped value of provider(java.util.Set) before task ':app:processDebugGoogleServices' has completed is not supported
```
#### Lösung: 
Im Ordner `android/build.gradle` die folgenden Zeilen anpassen:
```
buildscript {
    ext.kotlin_version = '1.7.10'
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath 'com.android.tools.build:gradle:7.3.0'
        // START: FlutterFire Configuration
		// ALT:
		// classpath 'com.google.gms:google-services:4.3.10'
		// NEU:
        classpath 'com.google.gms:google-services:4.3.5'
        // END: FlutterFire Configuration
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
    }
}
```
### Multidex Support
#### Fehlermeldung:
```
buildscript {
    ext.kotlin_version = '1.7.10'
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath 'com.android.tools.build:gradle:7.3.0'
        // START: FlutterFire Configuration
				// ALT:
				// classpath 'com.google.gms:google-services:4.3.10'
				// NEU:
        classpath 'com.google.gms:google-services:4.3.5'
        // END: FlutterFire Configuration
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
    }
}
```

#### Lösung:
Den Befehl `flutter run —debug` im Terminal ausführen und bei der Abfrage, ob multidex eingeschaltet werden soll mit `y` antworten. Mehr Infos dazu finden Sie in der offiziellen Dokumentation: [https://docs.flutter.dev/deployment/android#enabling-multidex-support](https://docs.flutter.dev/deployment/android#enabling-multidex-support).

## Fehlerteufel gesichtet
Leider sind uns im Buch ein paar kleinere Fehler unterlaufen. Eine Liste der Fehler mit den entsprechenden Korrekturen finden Sie im `FEHLERTEUFEL.md` Dokument in diesem Verzeichnis. Im Code selbst haben wir diese bereits behoben. Sollten Sie weitere Fehler finden, freuen wir uns über eine Nachricht von Ihnen. Schreiben Sie uns diese einfach im GitHub Repository in Form eines Issues oder schicken Sie uns eine E-Mail an `info@verena-zaiser.de`. Alternativ können Sie uns auch über unsere Webseite [losfluttern.de](https://losfluttern.de) kontaktieren.
