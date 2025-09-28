Locales = Locales or {}

Locales['de'] = {
    up          = "⬆️",
    down        = "⬇️",
    notify      = "%s (%s)",
    hint        = "%s\n%s%s",
    errorFloor  = "Fehler: Ungültiges Stockwerk!"
}

-- Helper to get texts
function _U(str, ...)
    if Locales['de'][str] then
        return string.format(Locales['de'][str], ...)
    end
    return 'MISSING LOCALE: ' .. str
end