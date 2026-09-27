import pytest
from app.services.browser import launch_browser

@pytest.mark.asyncio
async def test_launch_browser():
    async with launch_browser(headless=True) as browser:
        assert browser.is_connected()
