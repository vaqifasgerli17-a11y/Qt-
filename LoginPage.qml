import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: loginPageRoot
    width: 400
    height: 500
    color: "#e3f2fd" // Açıq mavi fon

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 15
        width: parent.width * 0.8

        Text {
            text: "Sistemə Giriş"
            font.pixelSize: 24
            font.bold: true
            color: "#1565c0"
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: 10
        }

        TextField {
            id: usernameInput
            placeholderText: "İstifadəçi adı"
            Layout.fillWidth: true
            Layout.preferredHeight: 40
            font.pixelSize: 14
        }

        TextField {
            id: passwordInput
            placeholderText: "Şifrə"
            echoMode: TextInput.Password // Şifrəni gizli (ulduzlu) edir
            Layout.fillWidth: true
            Layout.preferredHeight: 40
            font.pixelSize: 14
        }

        Button {
            text: "Daxil Ol"
            Layout.fillWidth: true
            Layout.preferredHeight: 45

            onClicked: {
                if (usernameInput.text === "admin" && passwordInput.text === "1234") {
                    console.log("Giriş uğurludur! Əsas səhifəyə keçilir...")
                    stackView.push("MainPage.qml") // Əsas səhifəyə keçid edir
                } else {
                    console.log("Xəta: İstifadəçi adı və ya şifrə yanlışdır!")
                }
            }
        }
    }
}
