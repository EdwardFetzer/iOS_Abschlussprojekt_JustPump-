//
//  NutritionResources.swift
//  JustPump
//
//  Created by Edward Fetzer on 11.11.22.
//

import Foundation

func getAllNutritions() -> [Nutrition] {
    return [
        // Basics
        Nutrition(
            nutritionName: "Basics",
            nutritionImageRes: "nutritionBasics",
            nutritionDescription: "Der erste Schritt bei jeder Ernährungsumstellung sollte stets die Bestimmung des Energiebedarfs sein. Jeder Mensch benötigt eine gewisse Menge an Kalorien, um die grundlegenden Körperfunktionen zu ermöglichen. Dieser Grundumsatz fällt sogar an, wenn ein Mensch 24 Stunden lang unbewegt im Bett liegt. Da wir uns aber bewegen, wird ein Aufschlag für die Aktivitäten hinzuaddiert. Körperlich besonders intensive Aktivitäten, etwa eine anstrengende Sporteinheit, können zusätzlich berechnet werden. Die konkreten Werte hängen von vielen Faktoren, wie etwa Alter, Geschlecht oder Größe ab. So ergibt sich der tägliche Energiebedarf, der selbst für wenig aktive Menschen mit kleinem Körperbau schnell bei mehr als 2.000 kcal liegt.\n\nDie erforderlichen Kalorien müssen je nach sportlichem Ziel in ein Verhältnis mit den aufgenommenen Kalorien gebracht werden. Aus diesem Grund ist es sinnvoll, die zugeführte Nahrung zu protokollieren, die Kalorien und Nährstoffe also zu tracken. Viele Hobbysportler sehen dieses Tracking als Belastung im ohnehin stressigen Alltag an. Glücklicherweise existieren mittlerweile unzählige Tracking-Apps und andere Fitness-Tools. Sehr beliebt ist die App „my fitness pal“, die den Energiebedarf schätzen, Barcodes scannen und die zugeführten Lebensmittel tracken kann. Alternativen, wie etwa „FatSecret“ weisen in der Regel ähnliche Funktionen auf und unterscheiden sich häufig nur im Design bzw. der Menüführung."),
        // Abnehmen
        Nutrition(
            nutritionName: "Abnehmen",
            nutritionImageRes: "nutritionAbnehmen",
            nutritionDescription: "Im Kaloriendefizit nimmst du ab\n\nFür ein erfolgreiches Abnehmen gibt es eine einfache Regel: Wer weniger Kalorien zu sich nimmt, als er verbraucht, nimmt automatisch ab.\n\nUm dieses Ziel zu erreichen, muss man jedoch den eigenen Kalorienbedarf (Energiebedarf) kennen. Der Kalorienbedarf eines Menschen setzt sich aus Grundumsatz (Grundbedarf) und Leistungsumsatz (Leistungsbedarf) zusammen. Der Grundumsatz beziffert die Anzahl der Kalorien, die der Körper in Ruhe verbraucht und ist abhängig von Faktoren wie Alter, Geschlecht, Größe und Gewicht. Der Leistungsumsatz setzt sich aus der täglichen körperlichen Aktivität in Beruf und Freizeit zusammen.\n\nDer Körper bezieht seine Energie hauptsächlich aus Kohlenhydraten, Eiweißen (Protein) und Fetten. Während Fett ca. 9,3 kcal pro Gramm enthält, sind es bei Kohlenhydraten und Eiweiß durchschnittlich nur 4,1 kcal pro Gramm. Um ein Kaloriendefizit zu erreichen, sollte man die Nährstoffverteilung im Blick behalten und insbesondere fettige Lebensmittel meiden. Auch ein aktiver Stoffwechsel spielt beim Abnehmen eine entscheidende Rolle."),
        // Muskelaufbau
        Nutrition(
            nutritionName: "Muskelaufbau",
            nutritionImageRes: "nutritionMuskelaufbau",
            nutritionDescription: "Grundsätzliches zur Muskelaufbau Ernährung\n\nEin sehr essenzieller Punkt für erfolgreichen Muskelaufbau ist die Energiezufuhr. Das Konzept ist denkbar einfach. In erster Linie muss der Körper die wichtigsten Vitalfunktionen, wie etwa Atmung und Blutkreislauf, antreiben. Dies nennt sich Grundumsatz (Seite folgt) und lässt sich also Energiebedarf bei 24 Stunden völliger Ruhe visualisieren.\n\nDa aber kein gesunder Mensch den ganzen Tag lang absolut still im Bett liegt, muss eine Energiemenge für die täglich Aktivität addiert werden. Körperlich arbeitende Menschen benötigen hier mehr zusätzliche Energie, aber auch geistige Arbeit verbraucht Kalorien. Zudem muss auch der Sport einberechnet werden. Dies alles nennt sich Leistungsumsatz und ergibt zusammen mit dem Grundumsatz den tatsächlichen Kalorienbedarf.\n\nDie Unterschiede zwischen Mann und Frau sind übrigens nicht so groß wie häufig angenommen wird. Bei einer vergleichbaren Statur reden wir von einem Unterschied von wenigen 100 Kalorien pro Tag, die sich der Kalorienbedarf der Geschlechter unterscheidet.\n\nür den Muskelaufbau ist der Kalorienbedarf sehr wichtig, da der Körper den Muskelaufbau erst an die dritte Stelle setzt. Erst wenn der Grundbedarf und der Energiebedarf für die täglichen Leistungen gedeckt sind, wird der Körper überschüssige Energie in neuer Muskelmasse speichern. Bei dieser überschüssigen Energie spricht man von einem Kalorienüberschuss, der als Faustregel 300 bis 500 Kalorien pro Tag betragen sollte. Da es schwer ist, die Kalorien rein durch das Körpergefühl im Blick zu behalten, greifen viele Athleten auf das Kalorien-Tracking zurück (zu Deutsch „Kalorien zählen“).\n\nNeben der reinen Kalorienmenge ist natürlich auch die Nährstoffverteilung für effektives Muskelwachstum wichtig. Muskeln bestehen zu einem wesentlichen Teil aus Proteinen. Daher ist es offensichtlich, dass die Muskelaufbau Ernährung proteinreich gehalten werden sollte. Es ist keineswegs nötig, Unmengen an Proteinen zuzuführen, allzu proteinarm sollte die Ernährung aber auch nicht sein.")
    ]
}
