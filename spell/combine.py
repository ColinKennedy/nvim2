import glob
import os

_CURRENT_DIRECTORY = os.path.dirname(os.path.realpath(__file__))
_ENCODING = "ascii"


def _get_all_lines(paths: list[str]):
    output: list[str] = []
    seen: set[str] = set()

    for path in paths:
        base_name = os.path.basename(path)

        with open(path, "r", encoding=_ENCODING) as handler:
            lines = handler.read().split("\n")

        contents: list[str] = []

        for line in lines:
            if line in seen:
                continue

            contents.append(line)

        if contents:
            output.append(f"# START - Generated {base_name} file")
            output.extend(contents)
            output.append(f"# END - Generated {base_name} file")

    if output:
        output.insert(
            0,
            (
                "1  # NOTE: This is supposed to be a word count. "
                "But apparently any number is fine."
            )
        )

    return output


def main():
    paths = glob.glob(os.path.join(_CURRENT_DIRECTORY, "parts", "*.dic"))
    lines = _get_all_lines(paths)
    blob = "\n".join(lines)

    with open(os.path.join(_CURRENT_DIRECTORY, "en-strict.dic"), "w", encoding=_ENCODING) as handler:
        handler.write(blob)


if __name__ == "__main__":
    main()
