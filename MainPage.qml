import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import QtQuick.LocalStorage

Rectangle {
    id: mainPageRoot
    width: 400
    height: 500
    color: "#f5f5f5"


    function getDatabase() {
        return LocalStorage.openDatabaseSync("SenedMeneceriDB", "1.0", "Materialların Bazası", 100000);
    }

    function initDatabase() {
        var db = getDatabase();
        db.transaction(function(tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS materiallar (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, type TEXT, url TEXT)');
        });
    }

    function insertMaterial(title, type, url) {
        var db = getDatabase();
        db.transaction(function(tx) {
            tx.executeSql('INSERT INTO materiallar (title, type, url) VALUES(?, ?, ?)', [title, type, url]);
        });
    }

    function deleteMaterial(url) {
        var db = getDatabase();
        db.transaction(function(tx) {
            tx.executeSql('DELETE FROM materiallar WHERE url = ?', [url]);
        });
    }

    function loadMaterials() {
        var db = getDatabase();
        myModel.clear();

        db.transaction(function(tx) {
            var rs = tx.executeSql('SELECT * FROM materiallar');
            for (var i = 0; i < rs.rows.length; i++) {
                myModel.append({
                    "title": rs.rows.item(i).title,
                    "type": rs.rows.item(i).type,
                    "url": rs.rows.item(i).url
                });
            }
        });
    }


    ListModel {
        id: myModel
    }

    FileDialog {
        id: fileDialog
        title: "Zəhmət olmasa bir PDF seçin"
        currentFolder: StandardPaths.writableLocation(StandardPaths.HomeLocation)
        nameFilters: ["PDF faylları (*.pdf)"]

        onAccepted: {
            var fullPath = fileDialog.selectedFile.toString();
            var fileName = fullPath.substring(fullPath.lastIndexOf('/') + 1);

            myModel.append({ "title": fileName, "type": "pdf", "url": fullPath });
            insertMaterial(fileName, "pdf", fullPath);
        }
    }


    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 15
        spacing: 15

        GroupBox {
            title: "Yeni Material Əlavə Et"
            Layout.fillWidth: true

            ColumnLayout {
                anchors.fill: parent
                spacing: 10

                Button {
                    text: "📂 Kompüterdən PDF Seç"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    onClicked: fileDialog.open()
                }

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 8

                    TextField {
                        id: linkInput
                        placeholderText: "Keçid linkini yazın (https://...)"
                        Layout.fillWidth: true
                        Layout.preferredHeight: 38
                        font.pixelSize: 14
                    }

                    Button {
                        text: "➕ Link Əlavə Et"
                        Layout.preferredHeight: 38
                        onClicked: {
                            if (linkInput.text.trim() !== "") {
                                var userLink = linkInput.text;
                                myModel.append({ "title": userLink, "type": "link", "url": userLink });
                                insertMaterial(userLink, "link", userLink);
                                linkInput.text = "";
                            }
                        }
                    }
                }
            }
        }

        Text {
            text: "Yüklənmiş Materiallar:"
            font.pixelSize: 16
            font.bold: true
            color: "#333333"
        }

        ListView {
            id: listView
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            model: myModel
            spacing: 8

            delegate: Rectangle {
                width: listView.width
                height: 50
                color: "white"
                radius: 6
                border.color: "#e0e0e0"
                border.width: 1

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10

                    Text {
                        text: (type === "pdf" ? "📄 " : "🔗 ") + title
                        font.pixelSize: 14
                        color: "#333333"
                        elide: Text.ElideRight
                        Layout.fillWidth: true
                    }

                    Button {
                        text: "Aç"
                        Layout.preferredHeight: 32
                        onClicked: Qt.openUrlExternally(url)
                    }

                    Button {
                        text: "Sil"
                        Layout.preferredHeight: 32
                        contentItem: Text {
                            text: "Sil"
                            color: "red"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: {
                            deleteMaterial(url);
                            myModel.remove(index);
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        initDatabase();
        loadMaterials();
    }
}
