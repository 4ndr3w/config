import threading
import subprocess
import sys

class bcolors:
	SELECTED_BACKGROUND_BACKGROUND = "%{B#abe15b}"
	SELECTED_TEXT_BACKGROUND = "%{F#abe15b}"
	SELECTED_TEXT_COLOR = "%{F#000000}"
	BACKGROUND_BACKGROUND_COLOR = "%{B#303030}"
	BACKGROUND_TEXT_COLOR = "%{F#303030}"
	WHITE_TEXT = "%{F#FFFFFF}"
	ARROW = "\ue0b0"
	ENDC = '%{B#000000}%{F#FFFFFF}'

p = subprocess.Popen(["/usr/bin/bspc", "subscribe", "report"], stdout=subprocess.PIPE)

workspaceState = []

def printGlyph(w, isStart=False, isEnd=False):
	if isStart:
		if w['status'] == "Focused":
			print(bcolors.SELECTED_TEXT_BACKGROUND+bcolors.SELECTED_BACKGROUND_BACKGROUND+bcolors.ARROW+bcolors.SELECTED_TEXT_COLOR, end='')
		else:
			print(bcolors.BACKGROUND_TEXT_COLOR+bcolors.BACKGROUND_BACKGROUND_COLOR+bcolors.ARROW+bcolors.WHITE_TEXT, end='')
	else:
		if w['status'] == "Focused":
			print(bcolors.BACKGROUND_TEXT_COLOR+bcolors.SELECTED_BACKGROUND_BACKGROUND+bcolors.ARROW+bcolors.SELECTED_TEXT_COLOR, end='')
		else:
			print(bcolors.BACKGROUND_TEXT_COLOR+bcolors.BACKGROUND_BACKGROUND_COLOR+bcolors.ARROW+bcolors.WHITE_TEXT, end='')

	print(w['contents'], end='')
	if isEnd:
		if w['status'] == "Focused":
			print(bcolors.ENDC+bcolors.SELECTED_TEXT_BACKGROUND, end='')
		else:
			print(bcolors.ENDC+bcolors.BACKGROUND_TEXT_COLOR, end='')

	else:
		if w['status'] == "Focused":
			print(bcolors.BACKGROUND_BACKGROUND_COLOR+bcolors.SELECTED_TEXT_BACKGROUND, end='')
		else:
			print(bcolors.BACKGROUND_TEXT_COLOR+bcolors.BACKGROUND_BACKGROUND_COLOR, end='')
	print(bcolors.ARROW, end='')
	print(bcolors.ENDC, end='')


def getStatus(state):
	if state is "O" or state is "F" or state is "U":
		return "Focused"
	elif state is "o" or state is "u":
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
			status = getStatus(workspace[0])
			if status == "Empty":
				continue
			newState.append({'contents': workspace[1:], 'status': status})
		workspaceState = newState			
		isFirst = True
		print("W", end="")
		for w in workspaceState[:-1]:
			printGlyph(w, isFirst, len(workspaceState)==1)
			isFirst = False
		printGlyph(workspaceState[-1], isFirst, True)
		print()
		sys.stdout.flush()
	p.poll()
thread()
