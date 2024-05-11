# Dev notes 
1. Ensure quickstart guide works (oauth)
- Followed https://developers.google.com/calendar/api/quickstart/python
- Did `pip install --upgrade google-api-python-client google-auth-httplib2 google-auth-oauthlib`
...actually did:
- `python3 -m venv .` from this dir
- `bin/pip3 install --upgrade google-api-python-client google-auth-httplib2 google-auth-oauthlib` from this dir
- Did `bin/python3 quickstart.py`
...it works!!

2. Try fetching specialized calendar...success (see commit for change)
