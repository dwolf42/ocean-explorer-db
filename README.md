Falls du eine MariaDB-Version älter als 10.10 verwendest, kann es beim Importieren des Dumps zu Fehlern kommen, da die Kollation `utf8mb4_uca1400_ai_ci` erst ab Version 10.10 unterstützt wird.

Prüfe zuerst deine Version:

  mariadb --version

Falls deine Version älter als 10.10 ist, musst du vor dem Import die Kollation im Dump ersetzen. Das geht mit folgendem Befehl:

  sed -i 's/utf8mb4_uca1400_ai_ci/utf8mb4_general_ci/g' ocean_explorer.sql

Danach kannst du den Dump normal importieren:

  mysql -u root -p < ocean_explorer.sql

Die Datenbank sollte danach ohne Probleme funktionieren.
