import { Loader } from "./common/Loader";
import { InputButtons } from "./common/InputButtons";
import { useBackend, useLocalState } from "../backend";
import { KEY_ENTER, KEY_ESCAPE } from "tgui-core/keycodes";
import { Box, Section, Stack, TextArea } from "tgui-core/components";
import { Window } from "../layouts";

export const sanitizeMultiline = (toSanitize) => {
	return toSanitize.replace(/(\n|\r\n){3,}/, "\n\n");
};

export const removeAllSkiplines = (toSanitize) => {
	return toSanitize.replace(/[\r\n]+/, "");
};


export const DominateTextInputModal = (props, context) => {
	const { act, data } = useBackend(context);
	const {
		large_buttons,
		max_length,
		guidelines = "",
		message = "",
		too_many_words_message = "",
		multiline,
		placeholder,
		title,
	} = data;
	const [input, setInput] = useLocalState(context, "input", placeholder || "");
	const onType = (value) => {
		if (value === input) {
			return;
		}
		const sanitizedInput = multiline
			? sanitizeMultiline(value)
			: removeAllSkiplines(value);
		setInput(sanitizedInput);
	};

	const visualMultiline = multiline || input.length >= 30;
	// Dynamically changes the window height based on the message.
	const windowHeight =
		205 +
		(too_many_words_message.length > 0 ? 10 : 0) +
		(guidelines.length > 30 ? Math.ceil(guidelines.length / 4) : 0) +
		(message.length > 30 ? Math.ceil(message.length / 4) : 0) +
		(visualMultiline ? 75 : 0) +
		(message.length && large_buttons ? 5 : 0);

	return (
		<Window title={title} width={325} height={windowHeight}>
			<Window.Content
				onKeyDown={(event) => {
					const keyCode = window.event ? event.which : event.keyCode;
					if (keyCode === KEY_ENTER && (!visualMultiline || !event.shiftKey)) {
						act("submit", { entry: input });
					}
					if (keyCode === KEY_ESCAPE) {
						act("cancel");
					}
				}}
			>
				<Section fill>
					<Stack fill vertical>
						<Stack.Item>
							<Box color="red">{guidelines}</Box>
						</Stack.Item>
						<Stack.Item>
							<Box color="label">{message}</Box>
						</Stack.Item>
						{!!(too_many_words_message.length > 0) && (
							<Stack.Item>
								<Box fontSize="8px" italic color="red">{too_many_words_message}</Box>
							</Stack.Item>
						)}
						<Stack.Item grow>
							<InputArea input={input} onType={onType} />
						</Stack.Item>
						
						<Stack.Item>
							<InputButtons
								input={input}
								message={`${input.length}/${max_length}`}
							/>
						</Stack.Item>
					</Stack>
				</Section>
			</Window.Content>
		</Window>
	);
};

/** Gets the user input and invalidates if there's a constraint. */
const InputArea = (props, context) => {
	const { act, data } = useBackend(context);
	const { max_length, multiline } = data;
	const { input, onType } = props;

	const visualMultiline = multiline || input.length >= 30;

	return (
		<TextArea
			autoFocus
			autoSelect
			height={multiline || input.length >= 30 ? "100%" : "1.8rem"}
			maxLength={max_length}
			onEscape={() => act("cancel")}
			onEnter={(event) => {
				if (visualMultiline && event.shiftKey) {
					return;
				}
				event.preventDefault();
				act("submit", { entry: input });
			}}
			onInput={(_, value) => onType(value)}
			placeholder="Type something..."
			value={input}
		/>
	);
};
