import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs

import Cells 1.0

Window {
    Cells {
        id: cells
        on_Cell_changed: {
            var idx = arguments[0]
            var val = arguments[1]
    //            console.log( idx, val)
            rpCells.itemAt( idx)._is_live = val
        }
    }

    onClosing: {
        console.log( "onClosing...")
        cells.stop()
        _rows = 0
        _cols = 0
        _len = 0
        model_maps.maps_name = []
    }

    property int _rows: cells.rows
    property int _cols: cells.cols
    property int _len:  cells.len

    height: _rows * _len + 10
    width:  _cols * _len + 230

    visible: true
    title: qsTr( "生命遊戲: " + _rows + "X" + _cols)

    Row {

        // 主要運算格子
        Grid {
            columns: _cols

            Repeater
            {
                id: rpCells
                model: _rows * _cols

                // 细胞
                Rectangle {
                    width: _len
                    height: _len
                    border.color: "lightGrey"

                    property bool _is_live: false
                    on_Is_liveChanged: {
                        if( _is_live)   color = "green"
                        else            color = "white"
                    }

                    MouseArea
                    {
                        anchors.fill: parent
                        onClicked:{
                            console.log( "點擊 ", index, cells.data[ index])
                            cells.set_data( index, ! _is_live)
                        }
                    }
                }
            }

        }


        // 按鈕操作區
        Column {
            leftPadding: 10
            topPadding: 10

            Row {
                Rectangle {
                    height: 20
                    width: 30
                    border.color: "blue"
                    anchors.verticalCenter: parent.verticalCenter
                    TextField {
                        id: txt_random_percent

                        font.pixelSize: 12
                        anchors.fill: parent
                        text: "30"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                Text {
                    text: qsTr(" %")
                    anchors.verticalCenter: parent.verticalCenter
                }

                Button {
                    text: qsTr("隨機")
                    onClicked: {
                        console.log( "txt_random_percent:", txt_random_percent.text)
                        cells.load_random( txt_random_percent.text)
                    }
                }

                Button {
                    text: qsTr("清空")
                    onClicked: {
                        cells.data_clear()
                    }
                }

            }

            // 地圖操作
            Row {

                Dialog {
                    id: dlg_save
                    title: "輸入名稱"

                    x: -500
                    y: 200

                    width: 240
                    height: 150
                    modal: false
                    standardButtons: Dialog.Ok | Dialog.Cancel

                    TextField {
                        id: txt_name
                        width: parent.width * 0.8
                        placeholderText: "name"
                    }

                    onAccepted: {
                        cells.save_map( txt_name.text)
                    }
                }

                Button {
                    text: qsTr("存檔")
                    onClicked: {
                        dlg_save.open()
                    }
                }

                Button {
                    text: qsTr("載入")
                    onClicked: {
//                        console.log( "name:", list_map.current_val)
                        cells.load_map( list_map.current_val)
                    }
                }

                Dialog {
                    id: dlg_del
                    title: "刪除"

                    x: -500
                    y: 200

                    width: 240
                    height: 150
                    modal: false
                    standardButtons: Dialog.Ok | Dialog.Cancel

                    Text {
                        text: qsTr("確定要刪除【" + list_map.current_val + "】嗎？")
                        color: "red"
                    }
                    onAccepted: {
                        var map_name = list_map.current_val
                        console.log( "map_name:", map_name)
                        cells.del_map( map_name)
                    }
                }

                Button {
                    text: qsTr("刪除")
                    onClicked: {
//                        console.log( "name:", list_map.current_val)
                        dlg_del.open()
                    }
                }
            }

            // ListView 外框
            Rectangle {
                width: 210
                height: 10 + 20*8
                radius: 5
                border.color: "blue"

                // 資料
                ListModel{
                    id: model_maps

                    property var maps_name: cells.maps_name
                    onMaps_nameChanged: {
                        model_maps.clear()
                        for (var i = 0; i < maps_name.length; ++i) {
                            model_maps.append( { name: maps_name[i]});
                        }
                    }
                }

                // ListView 控件
                ListView {
                    id: list_map

                    width: parent.width - 10
                    height: parent.height - 10
                    anchors.centerIn: parent

                    clip: true
                    focus: true

                    // 資料來源
                    model: model_maps

                    // 捲動
                    ScrollBar.vertical: ScrollBar {}

                    // 當前選擇：值
                    property string current_val: ""
                    onCurrentIndexChanged: {
                        current_val = model.get(currentIndex).name
                        console.log( "current_val:", current_val)
                    }

                    // 外觀定義
                    delegate: Text {
                        text: name

                        width: 180
                        height: 20
                        x: 5

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                list_map.currentIndex = index
                            }
                        }
                    }

                    // 當前選擇：標示
                    highlight: Rectangle {
                        height: 16
                        color: "lightsteelblue"
                        radius: 2
                    }
                } // ListView

            }   // ListView 外框

            // 按鈕
            Row {

                Button {
                    text: qsTr("開始/停止")
                    onClicked: {
                        cells.begin()
                    }
                }

                Button {
                    text: qsTr("單步")
                    onClicked: {
                        cells.step()
                    }
                }
            }

            Row {

                Button {
                    text: qsTr("+加速")
                    onClicked: {
                        cells.speed_up()
                    }
                }

                Button {
                    text: qsTr("-減速")
                    onClicked: {
                        cells.speed_down()
                    }
                }
            }

            Row {
                leftPadding: 32
                Button {
                    text: qsTr("上移")
                    onClicked: {
                        cells.shift_up()
                    }
                }
            }

            Row {
                Button {
                    text: qsTr("左移")
                    onClicked: {
                        cells.shift_left()
                    }
                }

                Button {
                    text: qsTr("右移")
                    onClicked: {
                        cells.shift_right()
                    }
                }
            }

            Row {
                leftPadding: 32
                Button {
                    text: qsTr("下移")
                    onClicked: {
                        cells.shift_down()
                    }
                }
            }

        }
    }

}
