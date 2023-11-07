#!/usr/bin/env python

import pandas as pd
import pyarrow as pa
import pyarrow.parquet as pq
import os

filename: str = os.environ.get('FILENAME', None)

def main():
  data = pd.read_table('./output/cas_operons_putative.tab')
  data['run'] = filename[5:8]
  data['AMG'] = filename[9:18]
  
  data = (
    data\
    .rename(columns={"Contig": "contig", 
                     "Operon": "operon",
                     "Start": "start",
                     "End": "end",
                     "Prediction": "prediction",
                     "Complete_Interference": "complete_interference",
                     "Complete_Adaptation": "complete_adaptation",
                     "Best_type": "best_type",
                     "Best_score": "best_score",
                     "Genes": "genes",
                     "Positions": "positions",
                     "E-values": "e_val"})
  )

  data['run'] = data.run.astype(int)

  columns = [
    pa.field("run", pa.int32()),
    pa.field("AMG", pa.string()),
    pa.field("contig", pa.string()),
    pa.field("operon", pa.string()),
    pa.field("start", pa.int32()),
    pa.field("end", pa.int32()),
    pa.field("prediction", pa.bool_()),
    pa.field("complete_interference", pa.string()),
    pa.field("complete_adaptation", pa.string()),
    pa.field("best_type", pa.string()),
    pa.field("best_score", pa.float64()),
    pa.field("genes", pa.string()),
    pa.field("positions", pa.string()),
    pa.field("e_val", pa.string())
  ]

  schema = pa.schema(columns)

  parquet_name = 'cctyper_output_' + filename + '.parquet'

  with pq.ParquetWriter(parquet_name, schema) as writer:
      table = pa.Table.from_pandas(data, preserve_index=False, schema=schema)
      writer.write_table(table)


if __name__ == '__main__':
    main()