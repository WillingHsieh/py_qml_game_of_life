import sqlite3
import os

class DB:
    file_name = "db.db"
    conn = None
    def __init__(self):
        if os.path.exists( self.file_name):
            self.conn = sqlite3.connect(self.file_name)
        else:
            self.conn = sqlite3.connect(self.file_name)
            self.create_table()

    def __del__(self):
        self.conn.close()

    def run_SQL(self, strSQL):
        result = self.conn.cursor().execute(strSQL)
        self.conn.commit()
        return result

    def create_table(self):
        strSQL = ("CREATE TABLE cells_map( "
                  "name NCHAR(50) PRIMARY KEY NOT NULL, "
                  "map NTEXT NOT NULL)")
        self.run_SQL( strSQL)

    def insert_data(self, name, str_map):
        strSQL = "INSERT INTO cells_map ( name, map)"
        strSQL += " VALUES ( '" + name + "', '" + str_map + "')"
        self.run_SQL(strSQL)

    def get_name_list(self):
        strSQL = "SELECT name FROM cells_map"
        cur = self.run_SQL(strSQL)
        ll = []
        for ii in cur:
            ll.append( ii[0])
        return ll

    def get_map(self, str_name):
        strSQL = "SELECT map FROM cells_map WHERE name='" + str_name + "'"
        cur = self.run_SQL(strSQL)
        # for m in cur.fetchall():
        #     print( eval( m[0])[ 0])
        return eval(cur.fetchall()[0][0])

    def del_data(self, name):
        strSQL = "DELETE FROM cells_map WHERE name='" + name + "'"
        return self.run_SQL(strSQL)

if __name__ == "__main__":
    db = DB()

    # db.create_table()
    # for i in range(10):
    #     db.insert_data("中文名稱_" + str(i), "中文內容_" + str(i))

    # db.del_data( "中文名稱_8")
    for i in db.get_name_list():
        print( i[0])
