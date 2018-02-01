import pandas as pd
from sqlalchemy import create_engine
import sqlalchemy
eng = sqlalchemy.create_engine("mysql+mysqldb://AQMUser:ConvolutionalNetwork123*@35.199.179.224:3306/Translink")

conn = eng.connect()
dataid = 1022
resoverall = conn.execute("""SELECT * 
                                    FROM WinBacks LIMIT 100""")

df = pd.DataFrame(resoverall.fetchall())
df.columns = resoverall.keys()
print(df)
