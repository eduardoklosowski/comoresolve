from unittest.mock import patch

import pytest

from comoresolve import BASE_URL, main


def test_run_script_with_success() -> None:
    with (
        patch('sys.argv', ['comoresolve', 'tests/exemple_success.py']),
        patch('comoresolve.webbrowser') as mock_browser,
    ):
        main()

    mock_browser.open.assert_not_called()


@pytest.mark.parametrize(
    ('script_name', 'error'),
    [
        ('tests/exemple_index.py', 'IndexError'),
        ('tests/exemple_zero_division.py', 'ZeroDivisionError'),
    ],
)
def test_run_script_with_error(script_name: str, error: str) -> None:
    with (
        patch('sys.argv', ['comoresolve', script_name]),
        patch('comoresolve.webbrowser') as mock_browser,
    ):
        main()

    mock_browser.open.assert_called_once()
    assert mock_browser.open.call_args.args[0].startswith(f'{BASE_URL}?q={error}%3A')


def test_run_module_with_success() -> None:
    with (
        patch('sys.argv', ['comoresolve', '-m', 'tests.exemple_success']),
        patch('comoresolve.webbrowser') as mock_browser,
    ):
        main()

    mock_browser.open.assert_not_called()


@pytest.mark.parametrize(
    ('module_name', 'error'),
    [
        ('tests.exemple_index', 'IndexError'),
        ('tests.exemple_zero_division', 'ZeroDivisionError'),
    ],
)
def test_run_module_with_error(module_name: str, error: str) -> None:
    with (
        patch('sys.argv', ['comoresolve', '-m', module_name]),
        patch('comoresolve.webbrowser') as mock_browser,
    ):
        main()

    mock_browser.open.assert_called_once()
    assert mock_browser.open.call_args.args[0].startswith(f'{BASE_URL}?q={error}%3A')
