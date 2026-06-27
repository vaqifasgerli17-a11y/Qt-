import QtQuick
import QtQuick.Controls

Window {
    id: window
    width: 400
    height: 500
    visible: true
    title: "Sənəd və Link Meneceri"

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: "LoginPage.qml"
    }
}
