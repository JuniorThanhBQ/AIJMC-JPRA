import shutil
from typing import AsyncGenerator
from contextlib import asynccontextmanager
from playwright.async_api import async_playwright, Browser, Page


def get_chromium_channel() -> str | None:
    if shutil.which("chromium") or shutil.which("chromium-browser"):
        return "chromium"
    return None


@asynccontextmanager
async def launch_browser(headless: bool = True) -> AsyncGenerator[Browser, None]:
    async with async_playwright() as playwright:
        channel = get_chromium_channel()
        launch_kwargs = {"headless": headless}
        if channel:
            launch_kwargs["channel"] = channel
        browser = await playwright.chromium.launch(**launch_kwargs)
        try:
            yield browser
        finally:
            await browser.close()


@asynccontextmanager
async def create_page(headless: bool = True) -> AsyncGenerator[Page, None]:
    async with launch_browser(headless=headless) as browser:
        page = await browser.new_page()
        try:
            yield page
        finally:
            await page.close()
