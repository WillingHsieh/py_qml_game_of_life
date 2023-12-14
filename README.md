# py_qml_game_of_life
康威生命遊戲（英語：Conway's Game of Life），又稱康威生命棋，
是英國數學家約翰·何頓·康威在1970年發明的細胞自動機。

生命遊戲中，對於任意細胞，規則如下：

    每個細胞有兩種狀態 - 存活或死亡，每個細胞與以自身為中心的周圍八格細胞產生互動（如圖，黑色為存活，白色為死亡）
    當前細胞為存活狀態時，當周圍的存活細胞低於2個時（不包含2個），該細胞變成死亡狀態。（模擬生命數量稀少）
    當前細胞為存活狀態時，當周圍有2個或3個存活細胞時，該細胞保持原樣。
    當前細胞為存活狀態時，當周圍有超過3個存活細胞時，該細胞變成死亡狀態。（模擬生命數量過多）
    當前細胞為死亡狀態時，當周圍有3個存活細胞時，該細胞變成存活狀態。（模擬繁殖）

可以把最初的細胞結構定義為種子，當所有在種子中的細胞同時被以上規則處理後，可以得到第一代細胞圖。按規則繼續處理當前的細胞圖，可以得到下一代的細胞圖，周而復始。

以上轉載自維基百科：https://zh.wikipedia.org/wiki/康威生命游戏

專案特點：

  * 非常簡潔：
    。只有 python 跟 QML 檔案，直接執行 main.py 即可
    。資料庫使用 sqlite3, 自動產生資料檔，自動創建資料表
  * 可在程式碼修改運算矩陣大小，格子大小。
* UI界面
    。可按百分比隨機產生有顏色的格子
    。可將地圖布局存檔/載入/刪除
    。滑鼠點擊編輯地圖
    。開始/暫停
    。單部執行
    。加速/減速運行速度
    。地圖上下左右平移功能

目前測試通過的平台

  * Mac OSX 14 + Python 3.11.6 

by English...

The Game of Life, also known simply as Life, is a cellular automaton devised by the 
British mathematician John Horton Conway in 1970.[1] It is a zero-player game,[2][3] meaning that 
its evolution is determined by its initial state, requiring no further input. 
One interacts with the Game of Life by creating an initial configuration and observing how it evolves. 
It is Turing complete and can simulate a universal constructor or any other

The above is reproduced from Wikipedia: https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life

Project features:

   * Very concise:
     . There are only python and QML files, just execute main.py directly
     . The database uses sqlite3 to automatically generate data files and automatically create data tables.
   * The operation matrix size and grid size can be modified in the program code.
   * UI interface
        . Colored grids can be randomly generated based on percentages
        . Map layout can be save/loaded/delete
        . Click with mouse to edit map
        . start/pause
        . Step execution
        . Accelerate/Decelerate running speed
        . Map can be shifted up, down, left and right

Currently tested platforms

   * Mac OSX 14 + Python 3.11.6
   * 