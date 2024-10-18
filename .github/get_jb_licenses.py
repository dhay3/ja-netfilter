import json
import os
import re
import requests
import logging

from lxml import etree

logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.INFO)

class cex(Exception):
    def __init__(self, message):
        super().__init__(message)


def get_raw_html(url: str = 'https://ipfs.io/ipfs/bafybeih65no5dklpqfe346wyeiak6wzemv5d7z2ya7nssdgwdz4xrmdu6i/') -> str:
    user_agent = ('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) '
                  'Chrome/58.0.3029.110 Safari/537.3')
    r = requests.get(url=url,
                     headers={
                         'User-Agent': user_agent
                     })
    if 200 == r.status_code:
        return r.text
    else:
        # TODO: When the exception has been raised, traverse the https://3.jetbra.in to get one of available sites
        # TODO: Use recursive function instead
        raise cex(f'http code is {r.status_code}')


def get_licenses(raw_html: str) -> []:
    def get_jbkeys(raw_html: str) -> {}:
        pattern = r'\s+let\sjbKeys\s='
        for line in raw_html.splitlines():
            if re.match(pattern, line):
                return json.loads(re.sub(pattern, '', line)[:-1].strip())

    jbkeys = get_jbkeys(raw_html)
    x_dom = etree.HTML(raw_html)
    articles = x_dom.xpath('//article[@data-sequence]')
    for article in articles:
        data_sequence = article.get('data-sequence')
        data_title = article.xpath('./descendant::h1')[0].get('title')
        data_version = article.xpath('./descendant::button[@data-version]')[0].get('data-version')
        logger.info(f'Gathering {data_title}.{data_version}')
        yield [f'{re.sub(r'[^\w\-.]', '_', data_title)}.{data_version}.license',
               jbkeys.get(data_sequence).get(data_version)]


def write_licenses(raw_html: str) -> None:
    jb_licenses = get_licenses(raw_html)
    os.makedirs('licenses', exist_ok=True)
    for jb_license in jb_licenses:
        with open(f'licenses/{jb_license[0]}', 'w') as f:
            f.write(jb_license[1])


def execute() -> None:
    raw_html = get_raw_html()
    write_licenses(raw_html)


if __name__ == '__main__':
    execute()