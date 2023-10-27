function unselectAllLines(parentElem: HTMLElement) {
  parentElem
    .querySelectorAll(".selected")
    .forEach((elem) => (elem.className = ""));
}

/**
 * Expected format of the url hash:
 *
 *	examples/allocations_familiales/prologue.catala_fr-13
 *	examples/allocations_familiales/prologue.catala_fr-13-15
 */
function getAllLineIds(urlHash: string): string[] | undefined {
  const matchedFileName = urlHash.match(/^(.*\.catala_)(fr|en)/g);
  if (matchedFileName === null) {
    return undefined;
  }
  const filename = matchedFileName[0];

  // Match final line number in url hash: #filename-1-2
  const [nums] = Array.from(urlHash.matchAll(/(\d+)($|\-(\d+)$)/g));
  if (nums === null) {
    return undefined;
  }
  const startNum = Number(nums[1]);
  const endNum = nums[3] != null ? Number(nums[3]) : startNum;

  return new Array(endNum - startNum + 1).fill(0).map((_, i) => {
    return (
      decodeURIComponent(filename)
        .normalize("NFD")
        .replace(/[\u0300-\u036f]/g, "") +
      "-" +
      (startNum + i)
    );
  });
}

function openParentDetails(lineToScroll: Element) {
  let parent = lineToScroll.parentNode as any;
  while (null != parent) {
    if ("DETAILS" == parent.nodeName) {
      parent.setAttribute("open", true);
      parent = null;
    } else {
      parent = parent.parentNode;
    }
  }
}

export default function (parentElem: HTMLElement | null, urlHash: string) {
  console.debug("scrollAndHightlightLine", parentElem, urlHash);
  if (parentElem == null) {
    return;
  }
  unselectAllLines(parentElem);

  const ids = getAllLineIds(urlHash);
  if (ids === undefined) {
    return;
  }

  const lineToScrollId = ids[Math.floor(ids.length / 2)]
    .replaceAll(/\./g, "\\.")
    .replaceAll(/\//g, "\\/");
  const lineToScroll = parentElem.querySelector("#" + lineToScrollId);
  if (lineToScroll === null) {
    return;
  }

  openParentDetails(lineToScroll);

  lineToScroll.scrollIntoView({ block: "center" });
  const links: HTMLCollection =
    lineToScroll?.parentNode?.getElementsByTagName("A");

  for (var i = 0; i < links.length; i++) {
    if (ids.some((id) => links[i].id.includes(id))) {
      links[i].className = "selected line";
    }
  }
}
