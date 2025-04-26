# llama_index_qa.py

## Build index
from llama_index.core import SimpleDirectoryReader, VectorStoreIndex
documents = SimpleDirectoryReader("impromptu").load_data()
index = VectorStoreIndex.from_documents(documents)
# save to disk
index.storage_context.persist()

## Query index
query_engine = index.as_query_engine()
response = query_engine.query('what is the potential of AI for Education?')
print(response)
sources = [s.node.get_text() for s in response.source_nodes]
print(sources[0][0:11])


