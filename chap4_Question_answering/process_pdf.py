# process_pdf.py

import requests, io, pypdf, os
# get the impromptu book
url = 'https://www.impromptubook.com/wp-content/uploads/2023/03/impromptu-rh.pdf'

def pdf_to_pages(file):
    "extract text (pages) from pdf file"
    pages = []
    pdf = pypdf.PdfReader(file)
    for p in range(len(pdf.pages)):
        page = pdf.pages[p]
        text = page.extract_text()
        pages += [text]
    return pages

r = requests.get(url)
f = io.BytesIO(r.content)
pages = pdf_to_pages(f)
# print(pages[1])

if not os.path.exists("impromptu"):
    os.mkdir("impromptu")
for i, page in enumerate(pages):
    with open(f"impromptu/{i}.txt","w", encoding='utf-8') as f:
        f.write(page)

sep = '\n'
book = sep.join(pages)
# print(book[0:35])
