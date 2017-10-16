import threading
import subprocess

#112
class bcolors:
	GREEN_BACKGROUND_BACKGROUND = "\033[48;2;175;215;0m"
	GREEN_BACKGROUND_TEXT = "\033[38;2;175;215;0m"
	GREEN_TEXT_TEXT = "\033[38;2;0;95;0m"
	GREEN_TEXT_BACKGROUND = "\033[48;2;0;95;0m"
	GRAY_BACKGROUND_BACKGROUND = "\033[48;2;48;48;48m"
	GRAY_BACKGROUND_TEXT = "\033[38;2;48;48;48m"
	WHITE_TEXT = "\033[38;2;255;255;255m"
	ARROW = "\ue0b0"
	OKGREEN = '\033[38;2;0;95;0m\033[48;2;175;215;0m\033[1m'
	ENDC = '\033[0m'

p = subprocess.Popen(["/usr/bin/bspc", "subscribe", "report"], stdout=subprocess.PIPE)

workspaceState = []

def printGlyph(w, isStart=False, isEnd=False):
	if isStart:
		if w['status'] == "Focused":
			print(bcolors.GREEN_BACKGROUND_TEXT+bcolors.GREEN_BACKGROUND_BACKGROUND+bcolors.ARROW+bcolors.GREEN_TEXT_TEXT, end='')
		else:
			print(bcolors.GRAY_BACKGROUND_TEXT+bcolors.GRAY_BACKGROUND_BACKGROUND+bcolors.ARROW+bcolors.WHITE_TEXT, end='')
	else:
		if w['status'] == "Focused":
			print(bcolors.GRAY_BACKGROUND_TEXT+bcolors.GREEN_BACKGROUND_BACKGROUND+bcolors.ARROW+bcolors.GREEN_TEXT_TEXT, end='')
		else:
			print(bcolors.GRAY_BACKGROUND_TEXT+bcolors.GRAY_BACKGROUND_BACKGROUND+bcolors.ARROW+bcolors.WHITE_TEXT, end='')

	print(w['contents'], end='')
	if isEnd:
		if w['status'] == "Focused":
			print(bcolors.ENDC+bcolors.GREEN_BACKGROUND_TEXT, end='')
		else:
			print(bcolors.ENDC+bcolors.GRAY_BACKGROUND_TEXT, end='')

	else:
		if w['status'] == "Focused":
			print(bcolors.GRAY_BACKGROUND_BACKGROUND+bcolors.GREEN_BACKGROUND_TEXT, end='')
		else:
			print(bcolors.GRAY_BACKGROUND_TEXT+bcolors.GRAY_BACKGROUND_BACKGROUND, end='')
	print(bcolors.ARROW, end='')
	print(bcolors.ENDC, end='')


def getStatus(state):
	if state is "O":
		return "Focused"
	elif state is "o":
		return "Active"
	else:
		return "Empty"
def thread():
	global workspaceState
	while not p.returncode:
		line = p.stdout.readline().split(b":")
		newState = []
		for l in range(1, 11):
			workspace = line[l].decode("utf-8")
			newState.append({'contents': workspace[1:], 'status': getStatus(workspace[0])})
		workspaceState = newState			
		isFirst = True
		for w in workspaceState[:-1]:
			printGlyph(w, isFirst)
			isFirst = False
		printGlyph(workspaceState[-1], False, True)
		print()
	p.poll()
thread()
